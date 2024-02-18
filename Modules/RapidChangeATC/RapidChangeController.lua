local RapidChangeController = {}

local inst = mc.mcGetInstance()

local function GcodeExecuteWait(formattedGcode, ...)
	local inst = mc.mcGetInstance()
	local gcode = string.format(formattedGcode, table.unpack(arg))
	
	local rc = mc.mcCntlGcodeExecuteWait(inst, gcode)

	return rc
end

function RapidChangeController.RapidToMachineCoordinates(XPos,YPos,ZPos)
	return GcodeExecuteWait("G90 G53 G00 Z0.0\nG90 G53 G00 X%.4f Y%.4f\nG00 G53 Z%.4f\n", XPos, YPos, ZPos)
end

function RapidChangeController.RapidToMachZ(zPos)
	--local gcode = code.Line({ code.RapidMach, code.Z(zPos) })
	--wx.wxMessageBox(gcode)
	local rc = mc.mcCntlGcodeExecuteWait(inst, "g90g53g0z10\n")
	return rc
end

function RapidChangeController.DoErrorTest()
	wx.wxMessageBox("This is an error test")
	error("This is the error")
end

return RapidChangeController
