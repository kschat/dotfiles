local awful = require('awful')
local gears = require('gears')

local naughty = require('naughty')
local beautiful = require('beautiful')
local wibox = require('wibox')
local hotkeys_popup = require('awful.hotkeys_popup').widget

local UpdateWidget = require('widget.update')
local VolumeWidget = require('widget.volume')
local ClientNameWidget = require('widget.client_name')

local util = require('util')
local notifications = require('notifications')
local bar = require('bar')
local sidebar = require('sidebar')
local context_menu = require('context_menu')
local bindings = require('input_bindings')

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

TERMINAL = 'alacritty'
EDITOR = os.getenv('EDITOR') or 'vim'
MODKEY = 'Mod4'

-- Clean up rogue processes
awful.spawn.with_shell('~/.config/awesome/awesome-cleanup')

beautiful.init(gears.filesystem.get_configuration_dir() .. 'theme.lua')

notifications.init()

context_menu.init {
  terminal = TERMINAL,
  hotkeys_popup_widget = hotkeys_popup,
}

local thrizen = require('thrizen')

-- awful.layout.suit.tile.ncols = 3

awful.layout.layouts = {
  thrizen,
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

-- TODO figure out if needed
-- local menubar = require('menubar')
-- menubar.utils.terminal = TERMINAL

screen.connect_signal('property::geometry', function (current_screen)
  return util.set_wallpaper(current_screen, beautiful.wallpaper)
end)

--
-- Widget configuration
--

local volume_widget = VolumeWidget {
  normal_color = beautiful.wibar_fg,
  mute_color = beautiful.colors.white,
}

local update_widget = UpdateWidget {
  interval_in_seconds = 5 * 60,
}

local clock_widget = wibox.widget.textclock('%a %b %_d %_I:%M%p')

local client_name_widget = ClientNameWidget {
  ellipsize = 'end',
  align = 'center',
  class_map = {
    ['Google-chrome'] = 'Google Chrome',
    ['Gnome-calculator'] = 'Calculator',
    ['jetbrains-idea-ce'] = 'IntelliJ IDEA',
  }
}

local search_widget = wibox.widget {
  font = beautiful.icon_font,
  text = '',
  align = 'center',
  widget = wibox.widget.textbox,
}

search_widget:buttons(gears.table.join(
  awful.button({}, 1, function ()
    awful.spawn('rofi -show drun')
  end)
))

local input_bindings = bindings.init {
  volume = volume_widget,
  hotkeys_popup_widget = hotkeys_popup,
  modkey = MODKEY,
  terminal = TERMINAL,
}

awful.rules.rules = {
  {
    rule = {},
    properties = {
      raise = true,
      focus = awful.client.focus.filter,
      buttons = input_bindings.buttons.client,
      keys = input_bindings.keys.client,
      screen = awful.screen.preferred,
      placement = awful.placement.no_overlap + awful.placement.no_offscreen,
      titlebars_enabled = true,
      maximized_horizontal = false,
      maximized_vertical = false,
      maximized = false,
      minimized = false
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
  },
  {
    rule = {
      class = 'zoom'
    },
    properties = {
      floating = true
    }
  }
}

--
-- Events
--

awful.screen.connect_for_each_screen(function(current_screen)
  util.set_wallpaper(current_screen, beautiful.wallpaper)

  current_screen.padding = {
    left = beautiful.screen_padding_left,
    top = beautiful.screen_padding_top,
    right = beautiful.screen_padding_right,
    bottom = beautiful.screen_padding_bottom
  }

  awful.tag(
    {
      '1  ',
      '2  ',
      '3  ',
      '4  ',
      '5  ',
      '6  ',
      '7  ',
      '8  ',
      '9  '
    },
    current_screen,
    awful.layout.layouts[1] -- iNdEXeS sTaRt At OnE
  )

  local tag_list_widget = awful.widget.taglist(
    current_screen,
    function(t, _) return t.selected end,
    gears.table.join(
      awful.button({}, 1, function(t) awful.tag.viewnext(t.screen) end),
      awful.button({}, 3, function(t) awful.tag.viewprev(t.screen) end)
    )
  )

  bar.init {
    screen = current_screen,
    client_name = client_name_widget:start(),
    volume = volume_widget:start(),
    clock = clock_widget,
    update = update_widget:start(),
    tag_list = tag_list_widget,
    search = search_widget,
  }

  sidebar.init {
    screen = current_screen,
    clock = clock_widget,
  }

  -- TODO add to bar
  --[[
  current_screen.layout_box = awful.widget.layoutbox(current_screen)
  current_screen.layout_box:buttons(gears.table.join(
    awful.button({}, 1, function() awful.layout.inc(1) end),
    awful.button({}, 3, function() awful.layout.inc(-1) end),
    awful.button({}, 4, function() awful.layout.inc(1) end),
    awful.button({}, 5, function() awful.layout.inc(-1) end)
  ))
  --]]
end)

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

