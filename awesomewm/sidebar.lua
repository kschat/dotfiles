local wibox = require('wibox')
local gears = require('gears')
local beautiful = require('beautiful')
local util = require('util')

local dpi = beautiful.xresources.apply_dpi

local sidebar = {}
local INITED = false

function sidebar.init(config)
  if INITED == true then
    error('Sidebar already initialized')
  end

  local current_screen = util.get_property(config, 'screen')
  local clock_widget = util.get_property(config, 'clock')

  local geo = current_screen.geometry

  local _sidebar = wibox {
    x = geo.width - 600 - dpi(30),
    y = dpi(85),
    -- y = 0,
    height = dpi(800),
    -- height = geo.height - dpi(115),
    -- height = geo.height,
    width = 600,
    bg = beautiful.colors.b_white,
    ontop = true,
    type = 'dock',
    visible = false,
    shape = function(cr, w, h)
      gears.shape.partially_rounded_rect(
        cr,
        w,
        h,
        true,
        true,
        true,
        true,
        dpi(20)
        -- beautiful.border_radius
      )
    end
  }

  _sidebar:setup {
    layout = wibox.layout.fixed.vertical,

    {
      widget = wibox.container.background,
      bg = beautiful.colors.b_white,
      fg = beautiful.colors.black,

      {
        widget = wibox.container.margin,
        top = dpi(20),
        bottom = dpi(20),
        left = dpi(20),
        right = dpi(20),

        {
          layout = wibox.layout.fixed.vertical,
          spacing = 10,

          {
            align = 'center',
            font = beautiful._huge_font,
            text = '08:38',
            widget = wibox.widget.textbox
          },
          {
            align = 'center',
            widget = clock_widget,
          },
          clock_widget,
        },
      }
    },
  }

  return {
    sidebar = _sidebar,
  }
end

return sidebar
