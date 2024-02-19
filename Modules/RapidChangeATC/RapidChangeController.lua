local RapidChangeController = {}
--Get mach instance
local inst = mc.mcGetInstance()

-- Gcode constants
local LINEAR_TO_MACH = "g90g53g1"
local LINEAR_INCREMENTAL = "g91g1"
local PROBE = "g90g31"
local RAPID_INCREMENTAL = "g91g0"
local RAPID_TO_MACH = "g90g53g0"
local ACTIVATE_TLO = "g43"
local CANCEL_TLO = "g49"
local COOLANT_STOP = "m9"
local DWELL = "g4"
local SPIN_STOP = "m5"
local SPIN_CW = "m3"
local SPIN_CCW = "m4"

--Formatting constants
local F1 = "%.1f"
local F2 = "%.2f"
local F4 = "%.4f"
local I = "%i"


--Word function builder
local function wordFunction(letter, format)
  return function (value)
    return string.format(letter .. format, value)
  end
end

--Word functions
local a = wordFunction("a", F4)
local b = wordFunction("b", F4)
local c = wordFunction("c", F4)
local x = wordFunction("x", F4)
local y = wordFunction("y", F4)
local z = wordFunction("z", F4)

local f = wordFunction("f", F2)
local g = wordFunction("g", I)
local h = wordFunction("h", I)
local m = wordFunction("m", I)
local p = wordFunction("p", F2)
local s = wordFunction("s", F1)

--Concats the provided args to a single string
local function concat(...)
	local result = ""
  local arg = {...}

  for _, v in ipairs(arg) do
    result = result .. v
  end

  return result
end

local function getAxisWord(axis, pos)
	if axis == k.X_AXIS then
		return x(pos)
	elseif axis == k.Y_AXIS then
		return y(pos)
	elseif axis == k.Z_AXIS then
		return z(pos)
	elseif axis == k.A_AXIS then
		return a(pos)
	elseif axis == k.B_AXIS then
		return b(pos)
	elseif axis == k.C_AXIS then
		return c(pos)
	else
		rcErrors.Throw("Invalid axis argument: getAxisWord(axis, pos)")
	end
end

-- Concats the provided args and adds a "\n", for composing a line of gcode
local function line(...)
  return concat(...) .. "\n"
end

local function spin(direction, speed)
	return line(direction, s(speed))
end

--Execute provided lines of gcode. Pass each line of gcode as a separate arg.
local function executeLines(...)
  local block = concat(...)
  local rc = mc.mcCntlGcodeExecuteWait(inst, block)

  rcErrors.HandleMachAPI(rc, string.format("Gcode:\n%s", block), "Gcode Execution Error")
end

local function getAxisPos(axis, useMach)
	local pos, rc
	if useMach then
		pos, rc = mc.mcAxisGetMachinePos(inst, axis)
	else
		pos, rc = mc.mcAxisGetPos(inst, axis)
	end
	rcErrors.HandleMachAPI(rc, "Error retrieving axis position.")

	return pos
end

local function getProbeMachPosZ()
	local pos, rc = mc.mcAxisGetProbePos(inst, mc.Z_AXIS, 1)
	rcErrors.HandleMachAPI(rc, "Error retrieving Z probe trigger position.")
end

local function getSignalHandle(id, prefix)
	if prefix ~= nil then
		local signalKey = string.format(prefix .. "%i", id)
		id = mc[signalKey]
	end

	local hsig, rc = mc.mcSignalGetHandle(inst, id)
	rcErrors.HandleMachAPI(rc, "Error getting signal handle.")
	return hsig
end

local function getSignalState(id, prefix)
	local hsig = getSignalHandle(id, prefix)
	local state, rc = mc.mcSignalGetState(hsig)
	rcErrors.HandleMachAPI(rc, "Error reading signal state.")
	return state
end

local function setSignalState(outputNum, state)
	local hsig = getSignalHandle(outputNum, "OSIG_OUTPUT")
	local rc = mc.mcSignalSetState(hsig, state)
	rcErrors.HandleMachAPI(rc, "Error setting signal state.")
end

--Controller state
local programUnits = nil

--Public controller functions
function RapidChangeController.GetCurrentTool()
	local tool, rc = mc.mcToolGetCurrent(inst)
	rcErrors.HandleMachAPI(rc, "Error getting current tool.")
	return tool
end

function RapidChangeController.SetCurrentTool(tool)
	local rc = mc.mcToolSetCurrent(inst, tool)
	rcErrors.HandleMachAPI(rc, "Error setting current tool.")
end

function RapidChangeController.GetSelectedTool()
	local tool, rc = mc.mcToolGetSelected(inst)
	rcErrors.HandleMachAPI(rc, "Error getting selected tool.")
	return tool
end

function RapidChangeController.ActivateTLO(tool)
	executeLines(line(ACTIVATE_TLO, h(tool)))
end

function RapidChangeController.CancelTLO()
	executeLines(line(CANCEL_TLO))
end

function RapidChangeController.SetTLO(tool)
	local offset = getProbeMachPosZ()
	local rc = mc.mcToolSetData(inst, mc.MTOOL_MILL_HEIGHT, tool, offset)
	rcErrors.HandleMachAPI(rc, "Error setting tool length offset.")
	--TODO: Should we dwell here? Not sure how to handle this. Mach4 docs say the
	--tool offset shouldn't be changed while gcode is running. Can we safely work around this?
end

function RapidChangeController.CoolantStop()
	executeLines(line(COOLANT_STOP))
end

function RapidChangeController.Dwell(seconds)
	executeLines(line(DWELL, p(seconds)))
end

function RapidChangeController.ExecuteMCode(mCodeNum)
	executeLines(line(m(mCodeNum)))
end

function RapidChangeController.RecordUnits()
	local units, rc = mc.mcCntlGetUnitsCurrent(inst)
	rcErrors.HandleMachAPI(rc, "Error recording units mode.")
	programUnits = units / 10
end

function RapidChangeController.RestoreUnits()
	if programUnits ~= nil then
		executeLines(line(g(programUnits)))
	end
end

function RapidChangeController.SetUnits(units)
	if units == 20 or units == 21 then
		executeLines(line(g(units)))
	end
end

--Reads input state for Input # inputs based on their number 0-63 
function RapidChangeController.GetInputState(inputNum)
	return getSignalState(inputNum, "ISIG_INPUT")
end

function RapidChangeController.GetOutputState(outputNum)
	return getSignalState(outputNum, "OSIG_OUTPUT")
end

function RapidChangeController.GetToolChangeState()
	return getSignalState(mc.OSIG_TOOL_CHANGE)
end

function RapidChangeController.ActivateOutput(outputNum)
	setSignalState(outputNum, k.ACTIVE)
end

function RapidChangeController.DeactivateOutput(outputNum)
	setSignalState(outputNum, k.INACTIVE)
end

--Spindle
function RapidChangeController.SpinCCW(speed)
	executeLines(spin(SPIN_CCW, speed))
end

function RapidChangeController.SpinCW(speed)
	executeLines(spin(SPIN_CW, speed))
end

function RapidChangeController.SpinStop()
	executeLines(SPIN_STOP)
end

--Movement
function RapidChangeController.RapidIncremental_Z(zDist)
	executeLines(RAPID_INCREMENTAL, z(zDist))
end
--Rapid machine coord move to zPosTraverse then to xPos, yPos, then to zPosTarget


--Rapid machine coord move to xPos, yPos, then to zPos
function RapidChangeController.RapidToMachCoords_XY_Z(xPos, yPos, zPos)
	executeLines(
		line(RAPID_TO_MACH, x(xPos), y(yPos)),
		line(RAPID_TO_MACH, z(zPos))
	)
end

function RapidChangeController.RapidToMachCoords_Z_XY_Z(zPosTraverse, xPos, yPos, zPosTarget)
	executeLines(
		line(RAPID_TO_MACH, z(zPosTraverse)),
		line(RAPID_TO_MACH, x(xPos), y(yPos)),
		line(RAPID_TO_MACH, z(zPosTarget))
	)
end

function RapidChangeController.LinearIncremental_Z(zDist, feed)
	executeLines(LINEAR_INCREMENTAL, z(zDist), f(feed))
end

function RapidChangeController.LinearToMachCoords_Z_Z(zPos1, zPos2, feed)
	executeLines(
		line(LINEAR_TO_MACH, z(zPos1), f(feed)),
		line(LINEAR_TO_MACH, z(zPos2), f(feed))
	)
end

function RapidChangeController.ProbeDown(maxDistance, feed)
	if maxDistance < 0 then 
		maxDistance = maxDistance * -1
	end

	local currentZPos = getAxisPos(mc.Z_AXIS)
	local targetZPos = currentZPos - maxDistance

	executeLines(line(PROBE, z(targetZPos), f(feed)))
end

function RapidChangeController.RapidToMachCoord(axis, pos)
	local axisWord = getAxisWord(axis, pos)
	executeLines(line(RAPID_TO_MACH, axisWord))
end

function RapidChangeController.RapidToMachCoord_Z(zPos)
	executeLines(line(RAPID_TO_MACH, z(zPos)))
end

return RapidChangeController
