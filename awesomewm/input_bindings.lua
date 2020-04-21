local awful = require('awful')
local gears = require('gears')
local util = require('util')

local key_bindings = {}
local INITED = false

function key_bindings.init(config)
  if INITED == true then
    error('Key bindings already initialized')
  end

  local volume_widget = util.get_property(config, 'volume')
  local hotkeys_popup = util.get_property(config, 'hotkeys_popup_widget')
  local modkey = util.get_property(config, 'modkey')
  local terminal = util.get_property(config, 'terminal')

  local scrot_notify = "notify-send -a 'screenshot' 'Taking screenshot...';"

  local scrot_base_cmd = "scrot '%Y-%m-%d_%H-%M-%S_$wx$h.png' "
    .. "--exec 'mv $f ~/Pictures/screenshots/'"

  local scrot_all_cmd = scrot_notify
    .. 'sleep 0.2 && '
    .. scrot_base_cmd

  local scrot_select_cmd = scrot_notify
    .. 'sleep 0.2 && '
    .. scrot_base_cmd
    .. ' --select'

  local global_keys = gears.table.join(
    awful.key({ modkey, 'Shift' }, '/', hotkeys_popup.show_help, {
      description = 'show help dialog',
      group = 'window manager'
    }),

    awful.key({ modkey }, 'Return', function() awful.spawn(terminal) end, {
      description = 'open a terminal',
      group = 'launcher'
    }),

    awful.key({ modkey }, 'p', function() awful.spawn('rofi -show drun') end, {
      description = 'open program lancher',
      group = 'launcher'
    }),

    awful.key({ modkey, 'Control' }, 'r', awesome.restart, {
      description = 'reload window manager',
      group = 'window manager'
    }),

    awful.key({ modkey, 'Control' }, 'Escape', awesome.quit, {
      description = 'quit window manager',
      group = 'window manager'
    }),

    awful.key({}, 'Print', function() awful.spawn.with_shell(scrot_all_cmd) end, {
      description = 'Take screenshot of entire screen',
      group = 'utility'
    }),

    awful.key({ 'Shift' }, 'Print', function() awful.spawn.with_shell(scrot_select_cmd) end, {
      description = 'Take screenshot of selected area',
      group = 'utility'
    }),

    util.create_select_and_move_window_binding('h', 'left'),
    util.create_select_and_move_window_binding('j', 'down'),
    util.create_select_and_move_window_binding('k', 'up'),
    util.create_select_and_move_window_binding('l', 'right'),

    awful.key({}, 'XF86AudioRaiseVolume', volume_widget.increase_volume, {
      description = 'increase volume',
      group = 'sound'
    }),

    awful.key({}, 'XF86AudioLowerVolume', volume_widget.decrease_volume, {
      description = 'decrease volume',
      group = 'sound'
    }),

    awful.key({}, 'XF86AudioMute', volume_widget.toggle_mute, {
      description = 'toggle mute',
      group = 'sound'
    })
  )

  for i = 1, 9 do
    global_keys = gears.table.join(
      global_keys,

      awful.key(
        { modkey },
        '#' .. i + 9,
        function()
          local screen = awful.screen.focused()
          local tag = screen.tags[i]
          if tag then tag:view_only() end
        end,
        {
          description = 'switch to tag #' .. i,
          group = 'window manager'
        }
      ),

      awful.key(
        { modkey, 'Shift' },
        '#' .. i + 9,
        function()
          if client.focus then
            local tag = client.focus.screen.tags[i]
            if tag then client.focus:move_to_tag(tag) end
          end
        end,
        {
          description = 'move focused client to tag #' .. i,
          group = 'window manager'
        }
      )
    )
  end

  local client_keys = gears.table.join(
    awful.key({ modkey }, 'q', function(c) c:kill() end, {
      description = 'close',
      group = 'client'
    }),

    awful.key(
      { modkey, 'Shift' },
      'f',
      function(c) c.fullscreen = not c.fullscreen; c:raise() end,
      {
        description = 'toggle fullscreen',
        group = 'window manager'
      }
    ),

    awful.key({ modkey }, 'f', awful.client.floating.toggle, {
      description = 'toggle fullscreen',
      group = 'window manager'
    })
  )

  local client_buttons = gears.table.join(
    awful.button({}, 1, function(c) client.focus = c; c:raise() end),
    awful.button({ modkey }, 1, function(c) awful.mouse.client.move(c) end),
    awful.button({ modkey }, 3, awful.mouse.client.resize)
  )

  root.keys(global_keys)

  return {
    keys = {
      global = global_keys,
      client = client_keys,
    },
    buttons = {
      global = {},
      client = client_buttons,
    },
  }
end

return key_bindings

