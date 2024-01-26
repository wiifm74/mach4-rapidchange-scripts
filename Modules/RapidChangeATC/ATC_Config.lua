--[[
RapidChange ATC Configuration
This file contains the settings for confuring RapidChange ATC for Mach4.
Go to the Settings section and enter the appropriate values for your configuration.
--]]

local ATC_Config = {}

--[[
Options
This section defines available options for certain RapidChange ATC settings.
DO NOT EDIT this section.
You will choose from options defined here when editing the Settings section.
--]]

ATC_Config.Axis = {
  X = {},
  Y = {},
}

local X = "X"
local Y = "Y"
local Positive = 1
local Negative = -1
local Inches = 20
local Millimeters = 21

Axis = {
  X = "X",
  Y = "Y",
  Z = "Z",
  A = "A",
  B = "B",
  C = "C"
}

-- Dust Cover Options
DustCoverMode = {
  Disabled = 0,
  Axis = 1,
  Output = 2,
}


--[[
Settings
Edit the values in this section to configure your RapidChange ATC Magazine for ATC operations.
Information for 
--]]

-- Tool Change Settings
ATC_Config.Units                  = Inches    -- Units for the configuration values, must match reporting units for Mach4 Profile
ATC_Config.Alignment              = X          -- X or Y: Axis on which the magazine is aligned.
ATC_Config.Direction              = Positive   -- Positive or Negative: Direction of travel from Pocket 1 to Pocket 2.
ATC_Config.PocketCount            = 0        -- Number of tool pockets in the magazine.
ATC_Config.PocketOffset           = 0.000   -- Distance between pockets (center-to-center) along the alignment axis.
ATC_Config.XPocket1               = 0.000       -- X Position (Machine Coordinates) of the center of Pocket 1.
ATC_Config.YPocket1               = 0.000       -- Y Position (Machine Coordinates) of the center of Pocket 1.
ATC_Config.XManual                = 0.000        -- X Position (Machine Coordinates) for manual tool changes.
ATC_Config.YManual                = 0.000        -- Y Position (Machine Coordinates) for manual tool changes.
ATC_Config.ZEngage                = 0.000        -- Z Position (Machine Coordinates) for full engagement with the clamping nut.
ATC_Config.ZMoveToLoad            = 10.000    -- Z Position (Machine Coordinates) between unloading and loading a tool.
ATC_Config.ZMoveToProbe           = 10.000   -- Z Position (Machine Coordinates) after loading before setting TLO.
ATC_Config.ZSafeClearance         = 15.000 -- Z Position (Machine Coordinates) for clearance of all potential obstacles.
ATC_Config.LoadRPM                = 0.0          -- Spindle speed for loading a tool (Clockwise operation).
ATC_Config.UnloadRPM              = 0.0        -- Spindle speed for unloading a tool (Counterclockwise operation).
ATC_Config.EngageFeedrate         = 0.0   -- Feedrate for the engagement process.

-- Tool Touch Off Settings
ATC_Config.ToolTouchOffEnabled = false  -- true or false, whether or not to call the tool touch off macro after a tool change.
ATC_Config.ToolTouchOffMCode = 131      -- M Code for the tool touch off macro (Default is 931 for (M931));
ATC_Config.ToolSetterIsInternal = false -- true or false, whether the tool setter sits within a magazine pocket.
ATC_Config.XToolSetter = 5.000          -- X Position (Machine Coordinates) of the center of the tool setter.
ATC_Config.YToolSetter = 5.000          -- Y Position (Machine Coordinates) of the center of the tool setter.
ATC_Config.ZSeekStart = 5.000           -- Z Position (Machine Coordinates) of the start position for the seek function.
ATC_Config.ZSeekTarget = 4.5          -- Z Position (Machine Coordinates) of the furthest point of travel for the seek function.
ATC_Config.SeekRetreat = 0.2            -- The distance to retreat between the seek and set functions.
ATC_Config.SeekFeedrate = 11.8           -- Feedrate for the seek function.
ATC_Config.SetFeedrate = 3.9           -- Feedrate for the set function.

-- Tool Recognition Settings
ATC_Config.ToolRecognitionEnabled     = false -- true or false
ATC_Config.ToolRecognitionOverridden  = false  -- true or false, if true and tool recognition is disabled, will skip tool check
ATC_Config.ToolRecognitionInput       = 1
ATC_Config.ToolRecognitionActiveLow   = false
ATC_Config.ToolRecognitionZZone1      = 0.000
ATC_Config.ToolRecognitionZZone2      = 0.000

-- Dust Cover Settings
ATC_Config.DustCoverMode              = DustCoverMode.Disabled
ATC_Config.DustCoverAxis              = Axis.A
ATC_Config.DustCoverOpenPos           = 0.000
ATC_Config.DustCoverClosedPos         = 0.000
ATC_Config.DustCoverOutput            = 1       -- Output #
ATC_Config.DustCoverWait              = 1.0     -- Dwell time in seconds to allow cover to fully open or close
ATC_Config.AdjustForLimitedClearance  = false
ATC_Config.DustCoverOpenMCode         = 108
ATC_Config.DustCoverCloseMCode        = 109


-- Tool Change Hooks
ATC_Config.BeforeToolChangeMCode        = 91     -- M Code for custom macro to run at the start of a tool change, 0 is ignored
ATC_Config.AfterToolChangeMCode         = 0     -- M Code for custom macro to run after a tool change, 0 is ignored

return ATC_Config