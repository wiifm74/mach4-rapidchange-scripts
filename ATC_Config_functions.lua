function ATC_Config.GetPocketX(toolNum)
  -- If the tool does not have a magazine pocket, return the manual position
  if toolNum <= 0 or toolNum > ATC_Config.PocketCount then
    return ATC_Config.XManual
  end

  if ATC_Config.Alignment == Axis.X then
    return ATC_Config.XPocket1 + ((toolNum - 1) * ATC_Config.PocketOffset * ATC_Config.Direction)
  else
    return ATC_Config.XPocket1
  end
end

function ATC_Config.GetPocketY(toolNum)
  -- If the tool does not have a magazine pocket, return the manual position
  if toolNum <= 0 or toolNum > ATC_Config.PocketCount then
    return ATC_Config.YManual
  end

  if ATC_Config.Alignment == Axis.Y then
    return ATC_Config.YPocket1 + ((toolNum - 1) * ATC_Config.PocketOffset * ATC_Config.Direction)
  else
    return ATC_Config.YPocket1
  end
end

function ATC_Config.GetZRetreat()
  if ATC_Config.Units == Millimeters then
    return ATC_Config.ZEngage + 12
  else
    return ATC_Config.ZEngage + 0.47
  end
end

function ATC_Config.GetZSpindleStart()
  if ATC_Config.Units == Millimeters then
    return ATC_Config.ZEngage + 23
  else
    return ATC_Config.ZEngage + 0.91
  end
end

function ATC_Config.GetIRBeamBrokenState()
  if ATC_Config.ToolRecognitionActiveBroken == true then
    return 1
  else
    return 0
  end
end