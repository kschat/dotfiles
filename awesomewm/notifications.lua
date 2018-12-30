local naughty = require('naughty')
local gears = require('gears')
local beautiful = require('beautiful')

local notifications = {}
local INITED = false
local MAX_LINE_LENGTH = 150

local build_single_line_title = function(title)
  if title then
    return '<b>' .. title .. '</b> │ '
  else
    return ''
  end
end

local build_multiline_title = function(title)
  if title then
    return '<b>' .. title .. '</b>\n\n'
  else
    return ''
  end
end

function notifications.init()
  if INITED == true then
    error('Notifications already initialized')
  end

  naughty.config.padding = beautiful._notification_padding
  naughty.config.spacing = beautiful._notification_spacing

  naughty.config.defaults = gears.table.join(naughty.config.defaults, {
    position = beautiful._notification_position,
    margin = beautiful.notification_margin,
    icon_size = beautiful._notification_icon_size,
    timeout = 10,
  })

  naughty.config.presets = {
    low = {
      font = beautiful.notification_font,
      fg = beautiful.notification_fg,
      bg = beautiful.notification_bg,
      border_width = beautiful.notification_border_width,
      border_color = beautiful.notification_border_color,
      margin = beautiful.notification_margin,
      position = beautiful.notification_position,
    },
    normal = {
      font = beautiful.notification_font,
      fg = beautiful.notification_fg,
      bg = beautiful.notification_bg,
      border_width = beautiful.notification_border_width,
      border_color = beautiful.notification_border_color,
      margin = beautiful.notification_margin,
      position = beautiful.notification_position,
    },
    critical = {
      font = beautiful._notification_critical_font,
      fg = beautiful._notification_critical_fg,
      bg = beautiful._notification_critical_bg,
      border_width = beautiful._notification_critical_border_width,
      border_color = beautiful._notification_critical_border_color,
      margin = beautiful._notification_critical_margin,
      position = beautiful._notification_critical_position,
      timeout = 0,
    },
  }

  naughty.config.presets.ok = naughty.config.presets.low
  naughty.config.presets.info = naughty.config.presets.low
  naughty.config.presets.warn = naughty.config.presets.normal

  naughty.config.notify_callback = function(args)
    local app_name = args.appname

    if app_name == 'screenshot' then
      args.title = nil
      args.text = '  │  ' .. args.text
    end

    local title_length = args.title and args.title:len() or 0
    local text_length = args.text and args.text:len() or 0

    if text_length + title_length <= MAX_LINE_LENGTH then
      args.text = build_single_line_title(args.title) .. args.text
      args.title = nil
      return args
    end

    local message = gears.string.linewrap(args.text, 125)
    args.text = build_multiline_title(args.title) .. message
    args.title = nil

    return args
  end

  INITED = true
end

return notifications

