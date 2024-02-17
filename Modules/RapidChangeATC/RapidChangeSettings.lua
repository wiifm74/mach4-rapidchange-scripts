local RapidChangeSettings = {}

--Get Mach4 instance
local inst = mc.mcGetInstance()

--Setting definition creation helpers
local function createDefinition(key, label, description, settingType, defaultValue, options)
  defaultValue = defaultValue or {}
  options = options or {}

  return {
    key = key,
    label = label,
    description = description,
    settingType = settingType,
    defaultValue = defaultValue,
    options = options
  }
end

local function createOptionDefinition(key, label, description, options)
  return createDefinition(key, label, description, k.OPTION_SETTING, options[1], options)
end

--Setting definitions defined in display order for UI looping
local definitions = {
  --Tool Change
  createOptionDefinition("Units", "Units", "Units for this configuration.", k.UNIT_OPTIONS),
  createOptionDefinition("Alignment", "Alignment", "Axis on which the magazine is aligned.", k.ALIGNMENT_OPTIONS),
  createOptionDefinition("Direction", "Direction", "Direction of travel from Pocket 1 to Pocket 2.", k.DIRECTION_OPTIONS),
  createDefinition("PocketCount", "Pocket Count", "The number of tool pockets in your magazine.", k.COUNT_SETTING),
  createDefinition("PocketOffset", "Pocket Offset", "Distance between pockets (center-to-center) along the alignment axis.", k.UDISTANCE_SETTING),
  createDefinition("XPocket1", "X Pocket 1", "X Position (Machine Coordinates) of the center of Pocket 1.", k.DISTANCE_SETTING),
  createDefinition("YPocket1", "Y Pocket 1", "Y Position (Machine Coordinates) of the center of Pocket 1.", k.DISTANCE_SETTING),
  createDefinition("XManual", "X Manual", "X Position (Machine Coordinates) for manual tool changes.", k.DISTANCE_SETTING),
  createDefinition("YManual", "Y Manual", "Y Position (Machine Coordinates) for manual tool changes.", k.DISTANCE_SETTING),
  createDefinition("ZEngage", "Z Engage", "Z Position (Machine Coordinates) for full engagement with the clamping nut.", k.DISTANCE_SETTING),
  createDefinition("ZMoveToLoad", "Z Move To Load", "Z Position to rise to after unloading a tool, before moving to the pocket for loading.", k.DISTANCE_SETTING),
  createDefinition("ZMoveToProbe", "Z Move To Probe", "Z Position to rise to after loading a tool, before moving to the tool setter for probing.", k.DISTANCE_SETTING),
  createDefinition("ZSafeClearance", "Z Safe Clearance", "Z Position for the safe clearance of all obstacles.", k.DISTANCE_SETTING),
  createDefinition("LoadRPM", "Load RPM", "Spindle speed for loading a tool (Clockwise operation).", k.RPM_SETTING),
  createDefinition("UnloadRPM", "Unload RPM", "Spindle speed for unloading a tool (Counterclockwise operation).", k.RPM_SETTING),
  createDefinition("EngageFeedRate", "Engage Feed Rate", "Feed rate for the engagement process.", k.FEED_SETTING),

  --Tool Touch Off
  createDefinition("TouchOffEnabled", "Tool Touch Off Enabled", "Calls the configured Tool Touch Off M-Code after loading a tool.", k.SWITCH_SETTING),
  createDefinition("TouchOffMCode", "Tool Touch Off M-Code", "The M-Code for the tool touch off macro to be called after loading a tool.", k.MCODE_SETTING, 131),
  createDefinition("XToolSetter", "X Tool Setter", "X Position (Machine Coordinates) of the center of the tool setter.", k.DISTANCE_SETTING),
  createDefinition("YToolSetter", "Y Tool Setter", "Y Position (Machine Coordinates) of the center of the tool setter.", k.DISTANCE_SETTING),
  createDefinition("ZSeekStart", "Z Seek Start", "Z Position (Machine Coordinates) to begin the initial(seek) probe.", k.DISTANCE_SETTING),
  createDefinition("SeekMaxDistance", "Seek Max Distance", "Maximum distance of travel from Z Seek Start on initial probe. Used to calculate a probe target and guard against gross over travel.", k.UDISTANCE_SETTING),
  createDefinition("SeekFeedRate", "Seek Feed Rate", "Feedrate for the initial(seek) probe.", k.FEED_SETTING),
  createDefinition("SeekRetreat", "Seek Retreat", "Distance to retreat after trigger, before a subsequent(set) probe.", k.UDISTANCE_SETTING),
  createDefinition("SetFeedRate", "Set Feed Rate", "Feedrate for any subsequent(seek) probe.", k.FEED_SETTING),

  --Tool Recognition
  createDefinition("ToolRecognitionEnabled", "Tool Recognition Enabled", "Enable infrared tool recognition.", k.SWITCH_SETTING),
  createDefinition("ToolRecognitionOverride", "Tool Recognition Override", "", k.SWITCH_SETTING),
  createDefinition("IRPort", "IR Sensor Port", "Port number for the tool recognition IR sensor input.", k.PORT_SETTING),
  createDefinition("IRPin", "IR Sensor Pin", "Port number for the tool recognition IR sensor input.", k.PIN_SETTING),
  createDefinition("IRActiveBroken", "IR Active Broken", "Indication of whether the IR input is active when the beam is broken or when the beam is clear.", k.PIN_SETTING),
  createDefinition("ZZone1", "Z Zone 1", "Z Position (Machine Coordinates) for confirming the absence of a nut when unloading and the presence of a nut when loading.", k.DISTANCE_SETTING),
  createDefinition("ZZone2", "Z Zone 2", "Z Position (Machine Coordinates) for confirming complete threading when loading.", k.DISTANCE_SETTING),

  --Dust Cover
  createDefinition("DustCoverEnabled", "Dust Cover Enabled", "Enable programmatic dust cover control.", k.SWITCH_SETTING),
  createOptionDefinition("DustCoverControl", "Dust Cover Control", "Method for controlling the dust cover programmatically.", k.COVER_CONTROL_OPTIONS),
  createOptionDefinition("DustCoverAxis", "Dust Cover Axis", "Designated axis for controlling the dust cover.", k.COVER_AXIS_OPTIONS),
  createDefinition("DustCoverOpenPos", "Dust Cover Open Position", "Designated axis position (machine coordinates) at which the dust cover is fully open.", k.DISTANCE_SETTING),
  createDefinition("DustCoverClosedPos", "Dust Cover Closed Position", "Designated axis position (machine coordinates) at which the dust cover is fully closed.", k.DISTANCE_SETTING),
  createDefinition("DustCoverPort", "Dust Cover Port", "Port number for the dust cover output.", k.PORT_SETTING),
  createDefinition("DustCoverPin", "Dust Cover Pin", "Pin number for the dust cover output.", k.PIN_SETTING),
  createDefinition("DustCoverDwell", "Dust Cover Dwell", "Dwell time (seconds) to allow an output controlled dust cover to fully open or close.", k.DWELL_SETTING),
  createDefinition("DustCoverOpenMCode", "Dust Cover Open M-Code", "The assigned M-Code for opening the dust cover.", k.MCODE_SETTING),
  createDefinition("DustCoverCloseMCode", "Dust Cover Close M-Code", "The assigned M-Code for closing the dust cover.", k.MCODE_SETTING),

  --Hooks
  createDefinition("BeforeChangeMCode", "Before Change M-Code", "The M-Code for a custom macro to run before every tool change.", k.MCODE_SETTING),
  createDefinition("AfterChangeMCode", "After Change M-Code", "The M-Code for a custom macro to run after every tool change.", k.MCODE_SETTING),
}

local function isChecked(value)
  if value == k.ENABLED then
    return true
  elseif value == k.DISABLED then
    return false
  else
    return nil
  end
end

local function getOptionLabels(options)
  local labels = {}

  for i, v in ipairs(options) do
    labels[i] = v.label
  end

  return labels
end

local function getSelectedIndex(options, value)
  for i, v in ipairs(options) do
    if v.value == value then
      return i
    else
      return nil
    end
  end
end

--Setting Provider helper functions
local function createUISetting(definition)
  local value = RapidChangeSettings.GetValue(definition.key)

  return {
    key = definition.key,
    label = definition.label,
    description = definition.description,
    settingType = definition.settingType,
    optionLabels = getOptionLabels(definition.options),
    selectedIndex = getSelectedIndex(definition.options, value),
    isChecked = isChecked(value),
    value = value,
  }
end

--Setting Providers

--Local lookup map
local function buildDefinitionMap()
  local map = {}

  for _, v in ipairs(definitions) do
    map[v.key] = v
  end

  return map
end

local definitionMap = buildDefinitionMap()

--Retrieve a setting's value
function RapidChangeSettings.GetValue(key)
  local definition = definitionMap[key]

  if definition.settingType == k.DISTANCE_SETTING or
    definition.settingType == k.UDISTANCE_SETTING or
    definition.settingType == k.FEED_SETTING or
    definition.settingType == k.RPM_SETTING or
    definition.settingType == k.DWELL_SETTING
  then
    return mc.mcProfileGetDouble(inst, RC_SECTION, definition.key, definition.defaultValue)
  else
    return mc.mcProfileGetInt(inst, RC_SECTION, definition.key, definition.defaultValue)
  end
end

--Get an iterable list of settings for UI controls
function RapidChangeSettings.GetUISettingsList()
  local settings = {}

  for i, v in ipairs(definitions) do
    settings[i] = createUISetting(v)
  end

  return settings
end

--UIControl Registration
--Register the UI control upon construction, unregister upon destruction.
--This will allow for the handling of apapting control values to stored values to be handled by RapidChangeSettings.
--The UI can fetch the settings list and create whichever appropriate controls it chooses and let the
--settings worry about what to do with them. Indicate the control type used for the setting from the defined
--control type constants when registering a control.
local registeredControls = {}

function RapidChangeSettings.RegisterUIControl(key, control, controlType)
  registeredControls[key] = {
    control = control,
    controlType = controlType
  }
end

function RapidChangeSettings.UnregisterUIControl(key)
  --Is this enough for memory management?
  registeredControls[key] = nil
end

--Call from UI to save user input
--Settings will handle reading the input control and updating stored values
function RapidChangeSettings.SaveUISettings()
  --TODO: Save data from UI controls
end

return RapidChangeSettings