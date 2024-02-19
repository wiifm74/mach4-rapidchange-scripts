--[[
Temporary RapidChange ATC Configuration
This file contains a single function to load your configuration RapidChange ATC.
In the function RapidChangeUserConfig.load(), each line sets a value to a particular
RapidChange setting. See the format below:

rcSettings.SetValue(k.SETTING_NAME, Value)

Replace the Value parameter for each setting with the appropriate value for your configuration.
Values will either be numbers or one of a list of options.

For values that use options, see the format below:

-- Options: (OPTION_ONE, OPTION_TWO)
rcSettings.SetValue(k.SETTING_NAME, k.OPTION_ONE)

If you wanted to declare OPTION_TWO, change k.OPTION_ONE to k.OPTION_TWO:

-- Options: (OPTION_ONE, OPTION_TWO)
rcSettings.SetValue(k.SETTING_NAME, k.OPTION_TWO) 
--]]

local RapidChangeUserConfig = {}

function RapidChangeUserConfig.Load()
  -- Tool Change Settings

  -- Units for your configuration. Configure in your default units.
  -- Options: (MILLIMETERS, INCHES)
  rcSettings.SetValue(k.UNITS, k.MILLIMETERS)

  -- Axis on which the magazine is aligned.
  -- Options: (X_AXIS, Y_AXIS)
  rcSettings.SetValue(k.ALIGNMENT, k.X_AXIS)

  -- Direction of travel from Pocket 1 to Pocket 2.
  -- Options: (POSITIVE, NEGATIVE)
  rcSettings.SetValue(k.DIRECTION, k.POSITIVE)

  -- Number of tool pockets in the magazine.
  rcSettings.SetValue(k.POCKET_COUNT, 0)

  -- Distance between pockets (center-to-center) along the alignment axis.
  rcSettings.SetValue(k.POCKET_OFFSET, 0)

  -- X Position (Machine Coordinates) of the center of Pocket 1.
  rcSettings.SetValue(k.X_POCKET_1, 0.000)

  -- Y Position (Machine Coordinates) of the center of Pocket 1.
  rcSettings.SetValue(k.Y_POCKET_1, 0.000)

  -- X Position (Machine Coordinates) for manual tool changes.
  rcSettings.SetValue(k.X_MANUAL, 0.000)

  -- Y Position (Machine Coordinates) for manual tool changes.
  rcSettings.SetValue(k.Y_MANUAL, 0.000)

  -- Z Position (Machine Coordinates) for full engagement with the clamping nut.
  rcSettings.SetValue(k.Z_ENGAGE, 0.000)

  -- Z Position (Machine Coordinates) for traversal between unloading and loading a tool.
  rcSettings.SetValue(k.Z_MOVE_TO_LOAD, 0.000)

  -- Z Position (Machine Coordinates) for traversal between loading and probing a tool.
  rcSettings.SetValue(k.Z_MOVE_TO_PROBE, 0.000)

  -- Z Position (Machine Coordinates) for clearance of all potential obstacles.
  rcSettings.SetValue(k.Z_SAFE_CLEARANCE, 0.000)

  -- Spindle speed for loading a tool (Clockwise operation).
  rcSettings.SetValue(k.LOAD_RPM, 1000.0)

  -- Spindle speed for unloading a tool (Counterclockwise operation).
  rcSettings.SetValue(k.UNLOAD_RPM, 1000.0)

  -- Feed rate for the engagement process.
  rcSettings.SetValue(k.ENGAGE_FEED_RATE, 0.0)


  -- Tool Touch Off Settings

  -- Calls the configured Tool Touch Off M-Code after loading a tool when enabled.
  -- Options: (DISABLED, ENABLED)
  rcSettings.SetValue(k.TOUCH_OFF_ENABLED, k.DISABLED)

  -- M Code for the tool touch off macro (Default is 131 for the included tool touch off macro)
  -- You can reassign the M-Code for the included file or call a custom macro.
  rcSettings.SetValue(k.TOUCH_OFF_M_CODE, 131)

  -- X Position (Machine Coordinates) of the center of the tool setter.
  rcSettings.SetValue(k.X_TOOL_SETTER, 0.000)

  -- Y Position (Machine Coordinates) of the center of the tool setter.
  rcSettings.SetValue(k.Y_TOOL_SETTER, 0.000)

  -- Z Position (Machine Coordinates) to begin the initial(seek) probe.
  rcSettings.SetValue(k.Z_SEEK_START, 0.000)

  -- Maximum distance of travel from Z Seek Start on initial probe. 
  -- Used to calculate a probe target and guard against gross over travel.
  rcSettings.SetValue(k.SEEK_MAX_DISTANCE, 0.000)

  -- Feedrate for the initial(seek) probe.
  rcSettings.SetValue(k.SEEK_FEED_RATE, 0.0)

  -- Distance to retreat after trigger, before a subsequent(set) probe.
  rcSettings.SetValue(k.SEEK_RETREAT, 0.000)

  -- Feedrate for any subsequent(seek) probe.
  rcSettings.SetValue(k.SET_FEED_RATE, 0.0)


  -- Tool Recognition Settings

  -- Enable infrared tool recognition.
  -- Default disabled behavior is to pause for user confirmation on each load or unload
  -- Options: (DISABLED, ENABLED)
  rcSettings.SetValue(k.TOOL_REC_ENABLED, k.DISABLED)

  -- Enable tool recognition override.
  -- Enable override when tool recognition is disabled to override the default pause for confirmation
  -- WARNING: Tool change will NOT stop on a failed load or unload when using override.
  -- Options: (DISABLED, ENABLED)
  rcSettings.SetValue(k.TOOL_REC_ENABLED, k.DISABLED)

  -- IR Sensor input #, for Input #1 enter 1, Input #2 enter 2, etc.
  rcSettings.SetValue(k.IR_INPUT, 0)

  -- Indicate whether the IR input is active when the beam is broken or when the beam is clear.
  -- Options: (ACTIVE_BROKEN, ACTIVE_CLEAR)
  rcSettings.SetValue(k.IR_ACTIVE_STATE, k.ACTIVE_BROKEN)

  -- Z Position (Machine Coordinates) for confirming the absence of a nut when unloading and the presence of a nut when loading.
  rcSettings.SetValue(k.Z_ZONE_1, 0.000)

  -- Z Position (Machine Coordinates) for confirming complete threading when loading.
  rcSettings.SetValue(k.Z_ZONE_2, 0.000)


  -- Dust Cover Settings

  -- Enable programmatic dust cover control.
  -- Options: (DISABLED, ENABLED)
  rcSettings.SetValue(k.COVER_ENABLED, k.DISABLED)

  -- Method for controlling the dust cover programmatically.
  -- Options: (COVER_CONTROL_AXIS, COVER_CONTROL_OUTPUT)
  rcSettings.SetValue(k.COVER_CONTROL, k.COVER_CONTROL_AXIS)

  -- M Code for the open dust cover macro (Default is 108 for the included macro)
  -- You can reassign the M-Code for the included file or call a custom macro.
  rcSettings.SetValue(k.COVER_OPEN_M_CODE, 108)

  -- M Code for the close dust cover macro (Default is 109 for the included macro)
  -- You can reassign the M-Code for the included file or call a custom macro.
  rcSettings.SetValue(k.COVER_CLOSE_M_CODE, 109)

  -- Dust Cover Axis Control Settings

  -- Designated axis for controlling the dust cover with axis control.
  -- Options: (A_AXIS, B_AXIS, C_AXIS)
  rcSettings.SetValue(k.COVER_AXIS, k.A_AXIS)

  -- Designated axis position (machine coordinates) at which the dust cover is fully open.
  rcSettings.SetValue(k.COVER_OPEN_POS, 0.000)

  -- Designated axis position (machine coordinates) at which the dust cover is fully closed.
  rcSettings.SetValue(k.COVER_CLOSED_POS, 0.000)

  -- Dust Cover Output Control Settings

  -- Dust cover output #, for Output #1 enter 1, Output #2 enter 2, etc.
  rcSettings.SetValue(k.COVER_OUTPUT, 0)

  -- Dwell time (seconds) to allow an output controlled dust cover to fully open or close.
  rcSettings.SetValue(k.COVER_DWELL, 0.00)


  -- Hook Settings

  -- M-Code for a custom macro to run before every tool change
  -- Default is 0 and is ignored. (It does not call M0 with a value of 0)
  rcSettings.SetValue(k.BEFORE_CHANGE_M_CODE, 0)

  -- M-Code for a custom macro to run after every tool change
  -- Default is 0 and is ignored. (It does not call M0 with a value of 0)
  rcSettings.SetValue(k.AFTER_CHANGE_M_CODE, 0)
end

return RapidChangeUserConfig