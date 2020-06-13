local wibox = require('wibox')
local gears = require('gears')
local spawn = require('awful.spawn')

local VOLUME_SCRIPT = [[
  bash -c '
    pactl subscribe | grep --line-buffered "Event '"'change'"' on sink"
  '
]]

local update_text = function(widget, stdout)
  local mute = stdout:match('%[(o%D%D?)%]')
  local volume = stdout:match('(%d?%d?%d)%%')
  volume = tonumber(string.format('% 3d', volume))

  local color = widget.normal_color
  if mute == 'off' then
    color = widget.mute_color
  end

  local icon
  if (volume <= 100 and volume >= 41) then
    icon = ''
  elseif (volume <= 40 and volume >= 1) then
    icon = ' '
  else
    icon = '  '
  end

  widget.markup = '<span fgcolor="' .. color .. '">' .. volume .. '  ' .. icon .. '</span>'

  -- hack needed to fix memory leak, see this issue for more details:
  -- https://github.com/awesomeWM/awesome/issues/1490
  collectgarbage('collect')
end

local VolumeWidget = {}
VolumeWidget.__index = VolumeWidget

setmetatable(VolumeWidget, {
  __call = function (cls, ...)
    return cls.new(...)
  end
})

function VolumeWidget.new(options)
  local self = wibox.widget.textbox()

  gears.table.crush(self, VolumeWidget, true)
  self.normal_color = options.normal_color
  self.mute_color = options.mute_color
  self.markup = '<span fgcolor="' .. self.normal_color .. '">- </span>'
  self.started = false

  return self
end

function VolumeWidget:start()
  if self.started == true then return self end

  self.started = true

  -- sleeps until volume events are detected
  spawn.with_line_callback(VOLUME_SCRIPT, {
    stdout = function (_)
      spawn.easy_async({ 'sh', '-c', 'amixer get Master' }, function (stdout)
        update_text(self, stdout)
      end)
    end,
  })

  -- the script used to detect volume events won't run until an event is
  -- triggered (volume up/down/mute/etc.), thus the volume won't be displayed
  -- on startup without manually changing the volume. This automates "changing
  -- the volume".
  gears.timer {
    timeout = 0.5,
    autostart = true,
    single_shot = true,
    callback = function ()
      self.increase_volume(1)
      self.decrease_volume(1)
    end
  }

  return self
end

function VolumeWidget.increase_volume(percentage)
  spawn('amixer sset Master ' .. (percentage or 5) .. '%+', false)
end

function VolumeWidget.decrease_volume(percentage)
  spawn('amixer sset Master ' .. (percentage or 5) .. '%-', false)
end

function VolumeWidget.toggle_mute()
  spawn('amixer sset Master toggle', false)
end

return VolumeWidget

