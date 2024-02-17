local RapidChangeConstants = {}

-- Setting Types
RapidChangeConstants.DISTANCE_SETTING = 0
RapidChangeConstants.UDISTANCE_SETTING = 1
RapidChangeConstants.FEED_SETTING = 2
RapidChangeConstants.RPM_SETTING = 3
RapidChangeConstants.MCODE_SETTING = 4
RapidChangeConstants.OPTION_SETTING = 5
RapidChangeConstants.SWITCH_SETTING = 6
RapidChangeConstants.COUNT_SETTING = 7
RapidChangeConstants.PORT_SETTING = 8
RapidChangeConstants.PIN_SETTING = 9
RapidChangeConstants.DWELL_SETTING = 10

--UI Control Types
RapidChangeConstants.INPUT_CONTROL = 0
RapidChangeConstants.CHECK_CONTROL = 1
RapidChangeConstants.RADIO_CONTROL = 2
RapidChangeConstants.SELECT_CONTROL = 3
RapidChangeConstants.LISTBOX_CONTROL = 4
RapidChangeConstants.CHOICE_CONTROL = 5


-- Options
RapidChangeConstants.ALIGNMENT_OPTIONS = {
  { value = RapidChangeConstants.X_AXIS, label = "X Axis" },
  { value = RapidChangeConstants.Y_AXIS, label = "Y Axis" },
}

RapidChangeConstants.DIRECTION_OPTIONS = {
  { value = RapidChangeConstants.POSITIVE, label = "Positive" },
  { value = RapidChangeConstants.NEGATIVE, label = "Negative" },
}

RapidChangeConstants.COVER_AXIS_OPTIONS = {
  { value = RapidChangeConstants.A_AXIS, label = "A Axis" },
  { value = RapidChangeConstants.B_AXIS, label = "B Axis" },
  { value = RapidChangeConstants.C_AXIS, label = "C Axis" },
}

RapidChangeConstants.COVER_CONTROL_OPTIONS = {
  { value = RapidChangeConstants.COVER_CONTROL_AXIS, label = "Axis" },
  { value = RapidChangeConstants.COVER_CONTROL_OUTPUT, label = "Output" },
}

RapidChangeConstants.UNIT_OPTIONS = {
  { value = RapidChangeConstants.MILLIMETERS, label = "Millimeters" },
  { value = RapidChangeConstants.INCHES, label = "Inches" },
}

-- Switch Setting state
RapidChangeConstants.DISABLED = 0
RapidChangeConstants.ENABLED = 1

--Units
RapidChangeConstants.INCHES = 20
RapidChangeConstants.MILLIMETERS = 21

--Directions
RapidChangeConstants.POSITIVE = 1
RapidChangeConstants.NEGATIVE = -1

--Axes
RapidChangeConstants.X_AXIS = 0
RapidChangeConstants.Y_AXIS = 1
RapidChangeConstants.Z_AXIS = 2
RapidChangeConstants.A_AXIS = 3
RapidChangeConstants.B_AXIS = 4
RapidChangeConstants.C_AXIS = 5

--Dust Cover
RapidChangeConstants.COVER_CONTROL_AXIS = 0
RapidChangeConstants.COVER_CONTROL_OUTPUT = 1

return RapidChangeConstants