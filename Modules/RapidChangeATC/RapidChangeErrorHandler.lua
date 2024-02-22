local RapidChangeErrorHandler = {}

local function getErrorName(rc)
  local errorName = "UNKNOWN"

  for key, value in pairs(mc) do
    if value == rc and type(key) == "string" and string.sub(key, 1 ,6) == "MERROR" then
      errorName = key
    end
  end

  return errorName
end

local function showAPIError(rc)
  local errorName = getErrorName(rc)
  local title = "MachAPI Error"
  local header = string.format("MachAPI Error: %i %s\n\n", rc, errorName)
  local message = "A RapidChange script has encountered an unexpected error.\nThe error has been logged. If the problem persists, please contact RapidChange ATC support."

  rcLog.LogErrorMachAPI(rc, errorName)
  wx.wxMessageBox(header .. message, title)
  error(message)
end

function RapidChangeErrorHandler.GuardAPIError(rc)
  if rc == mc.MERROR_NOERROR then
    return
  else
    showAPIError(rc)
  end
end

function RapidChangeErrorHandler.Throw(message, title)
  title = title or "RapidChange ATC Error"
  message = message or "An unexpected error occured. No message provided."
  wx.wxMessageBox(message, title)
  error(message)
end

return RapidChangeErrorHandler