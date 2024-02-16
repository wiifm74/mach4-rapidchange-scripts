--[[
This file contains an array of settings for RapidChangeATC.

Each setting is indexed by it's storage key and has the following properties:
  label: Label for GUI controls
  description: Description for tool tips.
  default: Default value.
  options: List of options for select controls.
  value: The current value for the setting.

There is one public function: RapidChangeSettings.SetValue(key, value)
  This function will update the profile storage to the supplied value and then 
  retrieve the stored value and assign it to the setting's value property.
--]]

local RapidChangeSettings = {}

local inst = mc.mcGetInstance()

--Constants
RC_SECTION = "RapidChangeATC"
INT_SETTING = 0
DOUBLE_SETTING = 1
STRING_SETTING = 2
ALIGNMENT_OPTIONS = { rcConst.X_AXIS, rcConst.Y_AXIS }
DIRECTION_OPTIONS = { rcConst.POSITIVE, rcConst.NEGATIVE }
UNIT_OPTIONS = { rcConst.MILLIMETERS, rcConst.INCHES }


--Local functions

--Storage retrieval
local function getValue(key)
  if RapidChangeSettings[key].storageType == DOUBLE_SETTING then
    return mc.mcProfileGetDouble(inst, RC_SECTION, key, RapidChangeSettings[key].default)
  elseif RapidChangeSettings[key].storageType == INT_SETTING then
    return mc.mcProfileGetInt(inst, RC_SECTION, key, RapidChangeSettings[key].default)
  else
    return mc.mcProfileGetString(inst, RC_SECTION, key, RapidChangeSettings[key].default)
  end
end

-- Setting creation
local function createSetting(key, label, description, default, options, storageType)
  RapidChangeSettings[key] = {
    label = label,
    description = description,
    default = default,
    options = options,
    storageType = storageType
  }

  RapidChangeSettings[key].value = getValue(key)
end

local function createSettingDouble(key, label, description, default)
  if default == nil then default = 0.000 end
  createSetting(key, label, description, default, {}, DOUBLE_SETTING)
end

local function createSettingInt(key, label, description, default)
  if default == nil then default = 0 end
  createSetting(key, label, description, default, {}, INT_SETTING)
end

local function createSettingOption(key, label, description, options)
  createSetting(key, label, description, options[1], options, INT_SETTING)
end


--Define and create settings
createSettingOption("Units", "Units", "Units for this configuration.", UNIT_OPTIONS)
createSettingOption("Alignment", "Alignment", "Axis on which the magazine is aligned.", ALIGNMENT_OPTIONS)
createSettingOption("Direction", "Direction", "Direction of travel from Pocket 1 to Pocket 2.", DIRECTION_OPTIONS)
createSettingDouble("ZMoveToLoad", "Z Move To Load", "Z Position to rise to after unloading a tool, before moving to the pocket for loading.")
createSettingDouble("ZMoveToProbe", "Z Move To Probe", "Z Position to rise to after loading a tool, before moving to the tool setter for probing.")
createSettingDouble("ZSafeClearance", "Z Safe Clearance", "Z Position for the safe clearance of all obstacles.")

--Public function for updating a setting's value
function RapidChangeSettings.SetValue(key, value)
  local rc

  --Update storage
  if RapidChangeSettings[key].storageType == DOUBLE_SETTING then
    rc = mc.mcProfileWriteDouble(inst, RC_SECTION, key, value)
  elseif RapidChangeSettings[key].storageType == INT_SETTING then
    rc = mc.mcProfileWriteInt(inst, RC_SECTION, key, value)
  else
    rc = mc.mcProfileWriteString(inst, RC_SECTION, key, value)
  end

  --Update setting in memory
  RapidChangeSettings[key].value = getValue(key)

  return rc
end

return RapidChangeSettings