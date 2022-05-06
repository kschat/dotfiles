local wibox = require('wibox')
local gears = require('gears')
local beautiful = require('beautiful')
local util = require('util')

local dpi = beautiful.xresources.apply_dpi

local bar = {}
local INITED = false

function bar.init(config)
  if INITED == true then
    error('Bar already initialized')
  end

  local current_screen = util.get_property(config, 'screen')
  local update_widget = util.get_property(config, 'update')
  local client_name_widget = util.get_property(config, 'client_name')
  local volume_widget = util.get_property(config, 'volume')
  local tag_list_widget = util.get_property(config, 'tag_list')
  local clock_widget = util.get_property(config, 'clock')
  local search_widget = util.get_property(config, 'search')

  local left_bar = wibox {
    type = 'dock',
    visible = true,
    opacity = beautiful._wibar_opacity,
    bg = beautiful.wibar_bg,
    fg = beautiful.wibar_fg,
    screen = current_screen,
    x = beautiful._wibar_x,
    y = beautiful._wibar_y,
    width = beautiful.wibar_width,
    height = beautiful.wibar_height,
    shape = function(cr, w, h)
      gears.shape.rounded_rect(cr, w, h, beautiful._wibar_border_radius)
    end,
  }

  local right_bar_x_offset = beautiful._wibar_right_width
    + beautiful.screen_padding_right
    + (beautiful.useless_gap * 2)

  local right_bar = wibox {
    type = 'dock',
    visible = true,
    opacity = beautiful._wibar_opacity,
    bg = beautiful.wibar_bg,
    fg = beautiful.wibar_fg,
    screen = current_screen,
    x = current_screen.geometry.width - right_bar_x_offset,
    y = beautiful._wibar_y,
    width = beautiful._wibar_right_width,
    height = beautiful.wibar_height,
    shape = left_bar.shape,
  }

  right_bar:setup {
    widget = wibox.container.margin,
    top = beautiful._wibar_margin,
    bottom = beautiful._wibar_margin,
    right = beautiful._wibar_margin,
    left = beautiful._wibar_outer_margin,

    {
      layout = wibox.layout.align.horizontal,

      nil,

      {
        layout = wibox.layout.fixed.horizontal,

        clock_widget,
      },

      {
        layout = wibox.layout.fixed.horizontal,

        {
          widget = wibox.container.background,
          bg = beautiful._wibar_accent_bg_color,
          fg = beautiful._wibar_accent_fg_color,
          forced_width = dpi(50),
          shape = function(cr, w, h)
            gears.shape.rounded_rect(cr, w, h, beautiful._wibar_border_radius)
          end,

          search_widget,
        },
      },
    },
  }

  left_bar:setup {
    top = beautiful._wibar_margin,
    bottom = beautiful._wibar_margin,
    left = beautiful._wibar_margin,
    right = beautiful._wibar_outer_margin,
    widget = wibox.container.margin,

    {
      layout = wibox.layout.fixed.horizontal,

      {
        layout = wibox.layout.fixed.horizontal,

        {
          widget = wibox.container.background,
          forced_width = beautiful._wibar_app_title_width,
          bg = beautiful._wibar_accent_bg_color,
          fg = beautiful._wibar_accent_fg_color,
          shape = function(cr, w, h)
            gears.shape.rounded_rect(cr, w, h, beautiful._wibar_border_radius)
          end,


          {
            left = beautiful._wibar_outer_margin,
            right = beautiful._wibar_outer_margin,
            widget = wibox.container.margin,

            client_name_widget,
          },
        },
      },

      {
        layout = wibox.layout.fixed.horizontal,
        spacing = beautiful._wibar_large_spacing,

        -- VPN
        {
          widget = wibox.container.margin,
          left = beautiful._wibar_large_spacing,

          {
            text = '',
            widget = wibox.widget.textbox
          },
        },

        update_widget,

        tag_list_widget,

        volume_widget,
      },
    },
  }

  INITED = true

  return {
    left = left_bar,
    right = right_bar,
  }
end

return bar
