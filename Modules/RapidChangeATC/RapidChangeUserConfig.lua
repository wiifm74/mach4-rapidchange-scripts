--[[
Temporary RapidChange ATC Configuration
This file contains a single function to load your configuration RapidChange ATC.
In the function RapidChangeUserConfig.load(), each line sets a value to a particular
RapidChange setting. See the format below:

rcSettings.SetValue("NAME OF THE SETTING", Value)

Replace the default value for each setting with the appropriate value for your configuration.
These settings will soon be able to be accessed and updated through a wizard GUI.
For now they can be set using this file.

Settings that have pre-determined options are assigned constants. See the format below:
rcSettings.SetValue("NAME OF THE SETTING", rcConst.VALUE_ONE) -- Options: (VALUE_ONE, VALUE_TWO)

If you wanted to declare VALUE_TWO:
rcSettings.SetValue("NAME OF THE SETTING", rcConst.VALUE_TWO) -- Options: (VALUE_ONE, VALUE_TWO)


--]]

local RapidChangeUserConfig = {}

function RapidChangeUserConfig.load()
  rcSettings.SetValue("Units", rcConst.MILLIMETERS)     --Units for your configuration. Options: (MILLIMETERS, INCHES)
  rcSettings.SetValue("Alignment", rcConst.X_AXIS)      --Axis on which the magazine is aligned. Options: (X_AXIS, Y_AXIS)
  rcSettings.SetValue("Direction", rcConst.POSITIVE)    --Direction of travel from Pocket 1 to Pocket 2. Options: (POSITIVE, NEGATIVE)
  rcSettings.SetValue("ZMoveToLoad", -2.000)            --Z Position (Machine Coordinates) for traversal between unloading and loading a tool.
  rcSettings.SetValue("ZMoveToProbe", -1.000)           --Z Position (Machine Coordinates) for traversal between loading and probing a tool.
  rcSettings.SetValue("ZSafeClearance", 0.000)          --Z Position (Machine Coordinates) for clearance of all potential obstacles.
end

return RapidChangeUserConfig