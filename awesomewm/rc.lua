local awful = require('awful')
local gears = require('gears')

local naughty = require('naughty')
local beautiful = require('beautiful')
local menubar = require('menubar')
local wibox = require('wibox')

local hotkeys_popup = require('awful.hotkeys_popup').widget
local dpi = beautiful.xresources.apply_dpi

-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require('awful.hotkeys_popup.keys')
require('awful.autofocus')

if awesome.startup_errors then
  naughty.notify({
    preset = naughty.config.presets.critical,
    title = 'There were errors during startup!',
    text = awesome.startup_errors
  })
end

do
  local in_error = false
  awesome.connect_signal('debug::error', function (err)
    if in_error then return end
    in_error = true

    naughty.notify({
      preset = naughty.config.presets.critical,
      title = 'Oops, an error happened!',
      text = tostring(err)
    })

    in_error = false
  end)
end

beautiful.init(gears.filesystem.get_configuration_dir() .. 'theme.lua')

naughty.config.defaults = gears.table.join(naughty.config.defaults, {
  position = 'top_left',
  margin = dpi(10)
})

-- naughty.config.padding = dpi(10)
-- naughty.config.spacing = dpi(2)

naughty.config.notify_callback = function(args)
  gears.debug.dump(args, 'NOTIFICATION')
  local app_name = args.appname

  if app_name == 'screenshot' then
    args.title = nil
    args.text = '  │  ' .. args.text
  end

  return args
end

TERMINAL = 'urxvt'
EDITOR = os.getenv('EDITOR') or 'vim'
MODKEY = 'Mod4'

awful.layout.layouts = {
  awful.layout.suit.tile,
  awful.layout.suit.floating,
  awful.layout.suit.tile.left,
  awful.layout.suit.tile.bottom,
  awful.layout.suit.tile.top,
  awful.layout.suit.fair,
  awful.layout.suit.fair.horizontal,
  awful.layout.suit.spiral,
  awful.layout.suit.spiral.dwindle,
  awful.layout.suit.max,
  awful.layout.suit.max.fullscreen,
  awful.layout.suit.magnifier,
  awful.layout.suit.corner.nw,
  -- awful.layout.suit.corner.ne,
  -- awful.layout.suit.corner.sw,
  -- awful.layout.suit.corner.se,
}

local launcher_menu = awful.menu({
  items = {
    {
      'awesome',
      {
        {
          'hotkeys',
          function() return false, hotkeys_popup.show_help end
        },
        {
          'restart',
          awesome.restart
        },
        {
          'tile',
          function() awful.layout.set(awful.layout.suit.tile) end
        },
        {
          'float',
          function() awful.layout.set(awful.layout.suit.floating) end
        },
      },
      beautiful.awesome_icon
    },
    { 'terminal', TERMINAL },
    {
      'quit',
      awesome.quit
    }
  }
})

-- Mouse bindings
root.buttons(gears.table.join(
  awful.button({}, 3, function () launcher_menu:toggle() end)
))

-- TODO figure out if needed
-- menubar.utils.terminal = TERMINAL

local function set_wallpaper(current_screen)
  if not beautiful.wallpaper then return end

  local wallpaper = beautiful.wallpaper

  if type(wallpaper) == 'function' then
    wallpaper = wallpaper(current_screen)
  end

  gears.wallpaper.maximized(wallpaper, current_screen, true)
end

screen.connect_signal('property::geometry', set_wallpaper)

local clock = wibox.widget.textclock('%a %_I:%M%p')

clock:buttons(gears.table.join(
  awful.button({}, 1, function()
    naughty.notify({
      title = 'Test',
      text = 'This is a test'
    })
  end)
))

local client_name_widget = wibox.widget.textbox()
client_name_widget.ellipsize = 'end'
client_name_widget.align = 'center'

awful.screen.connect_for_each_screen(function(current_screen)
  set_wallpaper(current_screen)

  current_screen.padding = {
    left = beautiful.screen_padding_left,
    top = beautiful.screen_padding_top,
    right = beautiful.screen_padding_right,
    bottom = beautiful.screen_padding_bottom
  }

  awful.tag(
    { '1  ', '2  ', '3  ', '4  ', '5  ', '6  ', '7  ', '8  ', '9  ' },
    current_screen,
    awful.layout.layouts[1] -- iNdEXeS sTaRt At OnE
  )

  current_screen.layout_box = awful.widget.layoutbox(current_screen)
  current_screen.layout_box:buttons(gears.table.join(
    awful.button({}, 1, function() awful.layout.inc(1) end),
    awful.button({}, 3, function() awful.layout.inc(-1) end),
    awful.button({}, 4, function() awful.layout.inc(1) end),
    awful.button({}, 5, function() awful.layout.inc(-1) end)
  ))

  current_screen.task_list = awful.widget.tasklist(
    current_screen,
    -- function(t, _) return t.selected end,
    awful.widget.tasklist.filter.focused,
    gears.table.join(
      awful.button({}, 1, function() end)
    )
  )

  current_screen.tag_list = awful.widget.taglist(
    current_screen,
    function(t, _) return t.selected end,
    gears.table.join(
      awful.button({}, 1, function(t) awful.tag.viewnext(t.screen) end),
      awful.button({}, 3, function(t) awful.tag.viewprev(t.screen) end)
    )
  )

  current_screen.left_bar = wibox({
    type = 'dock',
    bg = beautiful.wibar_bg,
    fg = beautiful.wibar_fg,
    screen = current_screen,
    x = beautiful._wibar_x,
    y = beautiful._wibar_y,
    width = beautiful.wibar_width,
    height = beautiful.wibar_height,
    visible = true
  })

  local geo = current_screen.geometry
  local width = dpi(194)

  current_screen.right_bar = wibox({
    type = 'dock',
    bg = beautiful.wibar_bg,
    fg = beautiful.wibar_fg,
    screen = current_screen,
    x = geo.width - (width + beautiful.screen_padding_right + (beautiful.useless_gap * 2)),
    y = beautiful._wibar_y,
    width = width,
    height = beautiful.wibar_height,
    visible = true
  })

  current_screen.left_bar.shape = function(cr, w, h)
    gears.shape.partially_rounded_rect(
      cr,
      w,
      h,
      true,
      true,
      true,
      true,
      beautiful._wibar_border_radius
    )
  end

  current_screen.right_bar.shape = current_screen.left_bar.shape

  current_screen.right_bar:setup {
    left = beautiful._wibar_outer_margin,
    right = beautiful._wibar_outer_margin,
    widget = wibox.container.margin,

    {
      layout = wibox.layout.fixed.horizontal,
      spacing = beautiful._wibar_small_spacing,

      clock,

      {
        font = beautiful.icon_font,
        text = '│',
        widget = wibox.widget.textbox
      },

      {
        font = beautiful.icon_font,
        text = '',
        align = 'center',
        widget = wibox.widget.textbox
      }
    }
  }

  current_screen.left_bar:setup {
    left = beautiful._wibar_left_strip,
    right = beautiful._wibar_outer_margin,
    widget = wibox.container.margin,

    {
      layout = wibox.layout.fixed.horizontal,

      {
        layout = wibox.layout.fixed.horizontal,

        {
          widget = wibox.container.background,
          forced_width = dpi(175),
          bg = beautiful._wibar_accent_color,
          fg = beautiful.colors.b_white,

          {
            left = beautiful._wibar_outer_margin,
            right = beautiful._wibar_outer_margin,
            widget = wibox.container.margin,

            client_name_widget
            --[[
            {
              widget = wibox.widget.textbox,
              align = 'center',
              markup = '<b>Google Chrome</b>',
              ellipsize = 'end'
            }
            --]]
          }
        }
      },

      {
        layout = wibox.layout.fixed.horizontal,
        spacing = beautiful._wibar_large_spacing,

        {
          widget = wibox.container.margin,
          left = beautiful._wibar_large_spacing,

          {
            text = '',
            widget = wibox.widget.textbox
          }
        },

        {
          text = '19  ',
          widget = wibox.widget.textbox
        },

        current_screen.tag_list,

        -- current_screen.task_list,

        {
          text = '25  ',
          widget = wibox.widget.textbox
        }
      }
    }
  }
end)

local function create_select_and_move_window_binding(key, direction)
  local direction_label = ({ down = 'below', up = 'above' })[direction]

  local description = (direction_label ~= nil)
    and 'the window ' .. direction_label .. ' the current window'
    or 'the window to the ' .. direction .. ' of the current window'

  return gears.table.join(
    awful.key(
      { MODKEY },
      key,
      function(c) awful.client.focus.bydirection(direction) end,
      {
        description = 'focus ' .. description,
        group = 'window manager'
      }
    ),

    awful.key(
      { MODKEY, 'Shift' },
      key,
      function(c) awful.client.swap.bydirection(direction) end,
      {
        description = 'swap ' .. description,
        group = 'window manager'
      }
    )
  )
end

local global_keys = gears.table.join(
  awful.key({ MODKEY, 'Shift' }, '/', hotkeys_popup.show_help, {
    description = 'show help dialog',
    group = 'window manager'
  }),

  awful.key({ MODKEY }, 'Return', function() awful.spawn(TERMINAL) end, {
    description = 'open a terminal',
    group = 'launcher'
  }),

  awful.key({ MODKEY }, 'p', function() awful.spawn('rofi -show drun') end, {
    description = 'open program lancher',
    group = 'launcher'
  }),

  awful.key({ MODKEY, 'Control' }, 'r', awesome.restart, {
    description = 'reload window manager',
    group = 'window manager'
  }),

  awful.key({ MODKEY, 'Control' }, 'Escape', awesome.quit, {
    description = 'quit window manager',
    group = 'window manager'
  }),

  create_select_and_move_window_binding('h', 'left'),
  create_select_and_move_window_binding('j', 'down'),
  create_select_and_move_window_binding('k', 'up'),
  create_select_and_move_window_binding('l', 'right')
)

for i = 1, 9 do
  global_keys = gears.table.join(
    global_keys,

    awful.key(
      { MODKEY },
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
      { MODKEY, 'Shift' },
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

root.keys(global_keys)

local client_keys = gears.table.join(
  awful.key({ MODKEY }, 'q', function(c) c:kill() end, {
    description = 'close',
    group = 'client'
  }),

  awful.key(
    { MODKEY, 'Shift' },
    'f',
    function(c) c.fullscreen = not c.fullscreen; c:raise() end,
    {
      description = 'toggle fullscreen',
      group = 'window manager'
    }
  ),

  awful.key({ MODKEY }, 'f', awful.client.floating.toggle, {
    description = 'toggle fullscreen',
    group = 'window manager'
  })
)

local client_buttons = gears.table.join(
  awful.button({}, 1, function(c) client.focus = c; c:raise() end),
  awful.button({ MODKEY }, 1, function(c) awful.mouse.client.move(c) end),
  awful.button({ MODKEY }, 3, awful.mouse.client.resize)
)

awful.rules.rules = {
  {
    rule = {},
    properties = {
      raise = true,
      focus = awful.client.focus.filter,
      buttons = client_buttons,
      keys = client_keys,
      screen = awful.screen.preferred,
      placement = awful.placement.no_overlap + awful.placement.no_offscreen,
      titlebars_enabled = true
    }
  },

  {
    rule_any = {
      class = {
        'Gnome-calculator',
      }
    },
    properties = {
      floating = true
    }
  },

  {
    rule_any = {
      class = {
        'URxvt'
      },
    },
    properties = {
      size_hints_honor = false
    }
  }

  --[[
  {
    rule_any = {
      type = { "normal", "dialog" }
    },
    properties = { titlebars_enabled = true }
  },
  --]]
}

client.connect_signal('manage', function(current_client)
  if awesome.startup
    and not current_client.size_hints.user_position
    and not current_client.size_hints.program_position then

    awful.placement.no_offscreen(current_client)
  end

  current_client.shape = function(cr, w, h)
    gears.shape.rounded_rect(cr, w, h, beautiful.border_radius)
  end
end)

client.connect_signal('mouse::enter', function(current_client)
  if awful.layout.get(current_client.screen) ~= awful.layout.suit.magnifier
    and awful.client.focus.filter(current_client) then

    client.focus = current_client
  end
end)

-- TODO move to own module
do
  local timer = gears.timer({
    timeout = 0.01,
    single_shot = true,
    callback = function()
      if client.focus then return end
      client_name_widget.markup = '<b>Desktop</b>'
    end
  })

  local class_name_map = {
    ['Google-chrome'] = 'Google Chrome',
    ['Gnome-calculator'] = 'Calculator'
  }

  client.connect_signal('focus', function(current_client)
    timer:stop()
    local class_name = class_name_map[current_client.class] or current_client.class
    client_name_widget.markup = '<b>' .. class_name .. '</b>'
  end)

  client.connect_signal('unfocus', function(current_client)
    timer:again()
  end)
end

client.connect_signal('focus', function(current_client) end)

client.connect_signal('unfocus', function(current_client) end)

client.connect_signal('request::titlebars', function(current_client)
  local buttons = gears.table.join(
    awful.button({}, 1, function()
      client.focus = c
      c:raise()
      awful.mouse.client.move(c)
    end)
  )

  awful.titlebar(current_client, {
    size = beautiful.titlebar_size,
    position = beautiful.titlebar_position
  }):setup {
    layout = wibox.layout.align.horizontal
  }
end)

