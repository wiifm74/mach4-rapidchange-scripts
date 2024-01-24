--[[
RapidChange ATC Configuration
This file contains the settings for confuring RapidChange ATC for Mach4.
Go to the Settings section and enter the appropriate values for your configuration.
--]]

local RapidChangeATC_Configuration = {}

--[[
Options
This section defines available options for certain RapidChange ATC settings.
DO NOT EDIT this section.
You will choose from options defined here when editing the Settings section.
--]]
RapidChangeATC_Configuration.Axis = {
  X = {},
  Y = {},
}

local X = "X"
local Y = "Y"
local Positive = 1
local Negative = -1
local Inches = 20
local Millimeters = 21

--[[
Settings
Edit the values in this section to configure your RapidChange ATC Magazine for ATC operations.
Information for 
--]]

-- Tool Change Settings
RapidChangeATC_Configuration.Units = Millimeters
RapidChangeATC_Configuration.Alignment = X          -- X or Y: Axis on which the magazine is aligned.
RapidChangeATC_Configuration.Direction = Positive   -- Positive or Negative: Direction of travel from Pocket 1 to Pocket 2.
RapidChangeATC_Configuration.PocketCount = 0        -- Number of tool pockets in the magazine.
RapidChangeATC_Configuration.PocketOffset = 0.000   -- Distance between pockets (center-to-center) along the alignment axis.
RapidChangeATC_Configuration.XPocket1 = 0.000       -- X Position (Machine Coordinates) of the center of Pocket 1.
RapidChangeATC_Configuration.YPocket1 = 0.000       -- Y Position (Machine Coordinates) of the center of Pocket 1.
RapidChangeATC_Configuration.XManual = 0.000        -- X Position (Machine Coordinates) for manual tool changes.
RapidChangeATC_Configuration.YManual = 0.000        -- Y Position (Machine Coordinates) for manual tool changes.
RapidChangeATC_Configuration.ZEngage = 0.000        -- Z Position (Machine Coordinates) for full engagement with the clamping nut.
RapidChangeATC_Configuration.ZMoveToLoad = 0.000    -- Z Position (Machine Coordinates) between unloading and loading a tool.
RapidChangeATC_Configuration.ZMoveToProbe = 0.000   -- Z Position (Machine Coordinates) after loading before setting TLO.
RapidChangeATC_Configuration.ZSafeClearance = 0.000 -- Z Position (Machine Coordinates) for clearance of all potential obstacles.
RapidChangeATC_Configuration.LoadRPM = 0.0          -- Spindle speed for loading a tool (Clockwise operation).
RapidChangeATC_Configuration.UnloadRPM = 0.0        -- Spindle speed for unloading a tool (Counterclockwise operation).
RapidChangeATC_Configuration.EngageFeedrate = 0.0   -- Feedrate for the engagement process.

-- Tool Touch Off Settings
RapidChangeATC_Configuration.ToolTouchOffEnabled = false  -- true or false, whether or not to call the tool touch off macro after a tool change.
RapidChangeATC_Configuration.ToolTouchOffMCode = 931      -- M Code for the tool touch off macro (Default is 931 for (M931));
RapidChangeATC_Configuration.ToolSetterIsInternal = false -- true or false, whether the tool setter sits within a magazine pocket.
RapidChangeATC_Configuration.XToolSetter = 0.000          -- X Position (Machine Coordinates) of the center of the tool setter.
RapidChangeATC_Configuration.YToolSetter = 0.000          -- Y Position (Machine Coordinates) of the center of the tool setter.
RapidChangeATC_Configuration.ZSeekStart = 0.000           -- Z Position (Machine Coordinates) of the start position for the seek function.
RapidChangeATC_Configuration.ZSeekTarget = 0.000          -- Z Position (Machine Coordinates) of the furthest point of travel for the seek function.
RapidChangeATC_Configuration.SeekRetreat = 0.000          -- The distance to retreat between the seek and set functions.
RapidChangeATC_Configuration.SeekFeedrate = 0.0           -- Feedrate for the seek function.
RapidChangeATC_Configuration.SetFeedrate = 0.0           -- Feedrate for the set function.

-- Tool Recognition Settings
RapidChangeATC_Configuration.ToolRecognitionEnabled = false -- true or false
RapidChangeATC_Configuration.ToolRecognitionOverridden = false  -- true or false, if true and tool recognition is disabled, will skip tool check

-- Tool Change Hooks
RapidChangeATC_Configuration.AfterToolChangeHookEnabled = false
RapidChangeATC_Configuration.BeforeToolChangeHookEnabled = false
RapidChangeATC_Configuration.BeforeToolChangeMCode = 0
RapidChangeATC_Configuration.AfterToolChangeMCode = 0


return RapidChangeATC_Configuration