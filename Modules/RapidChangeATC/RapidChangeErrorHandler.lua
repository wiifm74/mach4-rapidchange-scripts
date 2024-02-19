local RapidChangeErrorHandler = {}

function RapidChangeErrorHandler.HandleMachAPI(rc, message, title)
  --If there's no error, there's nothing to do
  if rc == mc.MERROR_NOERROR then
    return
  end

	title = title or "Mach API Error"
  message = message or ""

  if rc == mc.MERROR_INVALID_INSTANCE then
    message = "Invalid Mach4 instance.\n" .. message
  elseif rc == mc.MERROR_INVALID_ARG then
    message = "Invalid argument.\n" .. message
  elseif rc == mc.MERROR_NOT_NOW then
    message = "Operation could not be completed at this time.\n" .. message
  elseif rc == mc.MERROR_NOT_COMPILED then
    message = "Compile error.\n" .. message
  elseif rc == mc.MERROR_SIGNAL_NOT_FOUND then
    message = "Signal not found.\n" .. message
  elseif rc == mc.MERROR_AXIS_NOT_FOUND then
    message = "Axis not found.\n" .. message
	else
		message = "Unknown error.\n" .. message
  end

  wx.wxMessageBox(message, title)
  error(message)
end

function RapidChangeErrorHandler.Throw(message, title)
  title = title or "RapidChange ATC Error"
  message = message or "An unexpected error occured. No message provided."
  wx.wxMessageBox(message, title)
  error(message)
end

return RapidChangeErrorHandler