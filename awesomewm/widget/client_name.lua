local wibox = require('wibox')
local gears = require('gears')

local DEFAULT_LABEL = '<b>Desktop</b>'

local ClientNameWidget = {}
ClientNameWidget.__index = ClientNameWidget

setmetatable(ClientNameWidget, {
  __call = function (cls, ...)
    return cls.new(...)
  end
})

function ClientNameWidget.new(options)
  local self = wibox.widget.textbox()

  gears.table.crush(self, ClientNameWidget, true)
  self.ellipsize = options.ellipsize
  self.align = options.align
  self.markup = DEFAULT_LABEL
  self.class_map = options.class_map or {}
  self.started = false

  return self
end

function ClientNameWidget:start()
  if self.started == true then return self end

  self.started = true

  local timer = gears.timer {
    timeout = 0.01,
    autostart = true,
    single_shot = true,
    callback = function()
      if client.focus then return end
      self.markup = DEFAULT_LABEL
    end
  }

  client.connect_signal('focus', function(current_client)
    if timer.started == true then
      timer:stop()
    end

    local class_name = self.class_map[current_client.class]
      or current_client.class
      or ''

    self.markup = '<b>' .. class_name .. '</b>'
  end)

  client.connect_signal('unfocus', function(current_client)
    timer:again()
  end)

  return self
end

return ClientNameWidget

