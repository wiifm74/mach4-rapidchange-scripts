local RapidChangeController = {}

function mcMacroFunctions.RapidToMachineCoordinates(XPos,YPos,ZPos)
	
	local rc
	local GCode = ""
	
	GCode = string.format("G90 G53 G00 Z0.0\nG90 G53 G00 X%.4f Y%.4f\nG00 G53 Z%.4f\n", XPos, YPos, ZPos)
	rc = mc.mcCntlGcodeExecuteWait(inst, GCode)
	return rc
	
end

return RapidChangeController
