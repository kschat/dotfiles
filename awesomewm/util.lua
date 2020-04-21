local gears = require('gears')
local awful = require('awful')

local util = {}

function util.get_property(table, property)
  local value = table[property]
  if value == nil then
    error('Required property "' .. property .. '" missing from table')
  end

  return value
end

function util.set_wallpaper(current_screen, wallpaper)
  if not wallpaper then return end

  if type(wallpaper) == 'function' then
    wallpaper = wallpaper(current_screen)
  end

  gears.wallpaper.maximized(wallpaper, current_screen, true)
end

function util.create_select_and_move_window_binding(key, direction)
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

return util
