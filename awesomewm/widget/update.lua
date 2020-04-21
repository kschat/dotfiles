local wibox = require('wibox')
local gears = require('gears')
local watch = require('awful.widget.watch')

local UpdateWidget = {}
UpdateWidget.__index = UpdateWidget

setmetatable(UpdateWidget, {
  __call = function (cls, ...)
    return cls.new(...)
  end
})

function UpdateWidget.new(options)
  local self = wibox.widget.textbox()

  gears.table.crush(self, UpdateWidget, true)
  self.text = '-  '
  self.interval = options.interval_in_seconds
  self.started = false

  return self
end

function UpdateWidget:start()
  if self.started == true then return self end

  self.started = true

  watch('bash -c \'checkupdates | wc -l\'', self.interval, function (_, stdout)
    self.text = tonumber(stdout) .. '  '

    -- hack needed to fix memory leak, see this issue for more details:
    -- https://github.com/awesomeWM/awesome/issues/1490
    collectgarbage('collect')
  end)

  return self
end

return UpdateWidget

