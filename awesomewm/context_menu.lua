local awful = require('awful')
local gears = require('gears')
local beautiful = require('beautiful')
local util = require('util')

local context_menu = {}
local INITED = false

function context_menu.init(config)
  if INITED == true then
    error('ContextMenu already initialized')
  end

  local terminal = util.get_property(config, 'terminal')
  local show_help = util.get_property(config, 'hotkeys_popup_widget').show_help

  local launcher_menu = awful.menu {
    items = {
      {
        'awesome',
        {
          {
            'hotkeys',
            function() return false, show_help end,
          },
          {
            'restart',
            awesome.restart,
          },
          {
            'tile',
            function() awful.layout.set(awful.layout.suit.tile) end,
          },
          {
            'float',
            function() awful.layout.set(awful.layout.suit.floating) end,
          },
        },
        beautiful.awesome_icon,
      },
      { 'terminal', terminal },
      {
        'quit',
        awesome.quit,
      },
    },
  }

  root.buttons(gears.table.join(
    awful.button({}, 3, function () launcher_menu:toggle() end)
  ))

  return {
    launcher = launcher_menu,
  }
end

return context_menu

