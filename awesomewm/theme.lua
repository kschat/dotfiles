local gears = require('gears')
local xresources = require('beautiful.xresources')
local dpi = xresources.apply_dpi

local colors = {
  bg = '#272C30',
  fg = '#C0C0C6',

  white = '#C0C0C6',
  black = '#272C30',
  red = '#E25C4D',
  yellow = '#EAE877',
  green = '#2AC194',
  cyan = '#30C1B5',
  blue = '#2FA3B5',
  magenta = '#DD54BB',

  b_white = '#F9F9FF',
  b_black = '#525D66',
  b_blue = '#2D3338',
}

local theme = {}

theme.colors = colors
-- Default variables
-- theme.font = 'Droid Sans ' .. dpi(6)
theme.font = 'Roboto Regular ' .. dpi(8)
theme.icon_font = 'FontAwesome ' .. dpi(8)
theme._huge_font = 'Roboto Regular ' .. dpi(25)
-- theme.font = 'Noto Sans Regular ' .. dpi(7.5)
theme.useless_gap = dpi(8)

-- wibar
-- theme.wibar_stretch = nil
-- theme.wibar_border_width = nil
-- theme.wibar_border_color = nil
-- theme.wibar_ontop = nil
-- theme.wibar_cursor = nil
-- theme.wibar_opacity = nil
-- theme.wibar_type = nil
-- theme.wibar_bgimage = nil
-- theme.wibar_shape = nil

theme.wibar_bg = colors.b_white
theme.wibar_fg = colors.black
theme.wibar_width = dpi(425)
theme.wibar_height = dpi(45)
theme._wibar_border_radius = dpi(45)
theme._wibar_right_width = dpi(190)
theme._wibar_opacity = 1

theme._wibar_accent_bg_color = colors.cyan
theme._wibar_accent_fg_color = colors.b_white
theme._wibar_outer_margin = dpi(30)
theme._wibar_left_strip = dpi(0)
theme._wibar_large_spacing = dpi(25)
theme._wibar_small_spacing = dpi(15)

local screen_padding = dpi(4)

theme.screen_padding_left = screen_padding
theme.screen_padding_top = theme.wibar_height + screen_padding * 2
theme._wibar_y = screen_padding + theme.useless_gap

theme.screen_padding_right = screen_padding

theme._wibar_x = theme.screen_padding_right + theme.useless_gap * 2

theme.screen_padding_bottom = screen_padding

theme.bg_normal = colors.bg
theme.fg_normal = colors.fg
theme.bg_focus = colors.cyan
-- theme.bg_urgent = nil
-- theme.bg_minimize = nil
-- theme.bg_systray = nil
-- theme.fg_normal = nil
-- theme.fg_focus = nil
-- theme.fg_urgent = nil
-- theme.fg_minimize = nil
theme.border_radius = dpi(7)
theme.border_width = dpi(0)
-- theme.border_normal = nil
-- theme.border_focus = nil
-- theme.border_marked = nil
theme.wallpaper = gears.filesystem.get_xdg_config_home() .. 'wallpapers/current'
-- theme.wallpaper = '/home/kyle/Pictures/wallpapers/white-flowers.png'
-- theme.fg_normal = nil
-- theme.bg_systray = nil

-- arcchart
-- theme.arcchart_border_color = nil
-- theme.arcchart_color = nil
-- theme.arcchart_border_width = nil
-- theme.arcchart_paddings = nil
-- theme.arcchart_thickness = nil

-- awesome
-- theme.awesome_icon = nil

-- calendar
-- theme.calendar_style = nil
-- theme.calendar_font = nil
-- theme.calendar_spacing = nil
-- theme.calendar_week_numbers = nil
-- theme.calendar_start_sunday = nil
-- theme.calendar_long_weekdays = nil

-- checkbox
-- theme.checkbox_border_width = nil
-- theme.checkbox_bg = nil
-- theme.checkbox_border_color = nil
-- theme.checkbox_check_border_color = nil
-- theme.checkbox_check_border_width = nil
-- theme.checkbox_check_color = nil
-- theme.checkbox_shape = nil
-- theme.checkbox_check_shape = nil
-- theme.checkbox_paddings = nil
-- theme.checkbox_color = nil

-- column
-- theme.column_count = nil

-- cursor
-- theme.cursor_mouse_resize = nil
-- theme.cursor_mouse_move = nil

-- enable
-- theme.enable_spawn_cursor = nil

-- fullscreen
theme.fullscreen_hide_border = true

-- gap
theme.gap_single_client = true

-- graph
-- theme.graph_bg = nil
-- theme.graph_fg = nil
-- theme.graph_border_color = nil

-- hotkeys
-- theme.hotkeys_bg = nil
-- theme.hotkeys_fg = nil
-- theme.hotkeys_border_width = nil
-- theme.hotkeys_border_color = nil
-- theme.hotkeys_shape = nil
-- theme.hotkeys_modifiers_fg = nil
-- theme.hotkeys_label_bg = nil
-- theme.hotkeys_label_fg = nil
-- theme.hotkeys_font = nil
-- theme.hotkeys_description_font = nil
-- theme.hotkeys_group_margin = nil

-- icon
-- theme.icon_theme = nil

-- layout
-- theme.layout_cornernw = nil
-- theme.layout_cornerne = nil
-- theme.layout_cornersw = nil
-- theme.layout_cornerse = nil
-- theme.layout_fairh = nil
-- theme.layout_fairv = nil
-- theme.layout_floating = nil
-- theme.layout_magnifier = nil
-- theme.layout_max = nil
-- theme.layout_fullscreen = nil
-- theme.layout_spiral = nil
-- theme.layout_dwindle = nil
-- theme.layout_tile = nil
-- theme.layout_tiletop = nil
-- theme.layout_tilebottom = nil
-- theme.layout_tileleft = nil

-- master
-- theme.master_width_factor = nil
-- theme.master_fill_policy = nil
-- theme.master_count = nil

-- maximized
-- theme.maximized_honor_padding = nil

-- menu
-- theme.menu_submenu_icon = nil
-- theme.menu_height = nil
-- theme.menu_width = nil
-- theme.menu_border_color = nil
-- theme.menu_border_width = nil
-- theme.menu_fg_focus = nil
-- theme.menu_bg_focus = nil
-- theme.menu_fg_normal = nil
-- theme.menu_bg_normal = nil
-- theme.menu_submenu = nil

-- notification
theme._notification_padding = dpi(10)
theme._notification_spacing = dpi(10)
theme._notification_border_radius = dpi(7)
theme._notification_icon_size = dpi(0)
theme._notification_position = 'top_middle'

theme._notification_critical_bg = colors.black
theme._notification_critical_fg = colors.b_white
theme._notification_critical_border_width = dpi(0)

theme.notification_bg = colors.b_white
theme.notification_fg = colors.black
theme.notification_border_width = dpi(0)
theme.notification_border_color = colors.b_white
theme.notification_margin = dpi(15)
theme.notification_opacity = 1

theme.notification_shape = function(cr, w, h)
  gears.shape.rounded_rect(cr, w, h, theme._notification_border_radius)
end

-- piechart
-- theme.piechart_border_color = nil
-- theme.piechart_border_width = nil
-- theme.piechart_colors = nil

-- progressbar
-- theme.progressbar_bg = nil
-- theme.progressbar_fg = nil
-- theme.progressbar_shape = nil
-- theme.progressbar_border_color = nil
-- theme.progressbar_border_width = nil
-- theme.progressbar_bar_shape = nil
-- theme.progressbar_bar_border_width = nil
-- theme.progressbar_bar_border_color = nil
-- theme.progressbar_margins = nil
-- theme.progressbar_paddings = nil

-- prompt
-- theme.prompt_fg = nil
-- theme.prompt_bg = nil
-- theme.prompt_fg_cursor = nil
-- theme.prompt_bg_cursor = nil
-- theme.prompt_font = nil

-- radialprogressbar
-- theme.radialprogressbar_border_color = nil
-- theme.radialprogressbar_color = nil
-- theme.radialprogressbar_border_width = nil
-- theme.radialprogressbar_paddings = nil

-- slider
-- theme.slider_bar_border_width = nil
-- theme.slider_bar_border_color = nil
-- theme.slider_handle_border_color = nil
-- theme.slider_handle_border_width = nil
-- theme.slider_handle_width = nil
-- theme.slider_handle_color = nil
-- theme.slider_handle_shape = nil
-- theme.slider_bar_shape = nil
-- theme.slider_bar_height = nil
-- theme.slider_bar_margins = nil
-- theme.slider_handle_margins = nil
-- theme.slider_bar_color = nil

-- snap
-- theme.snap_bg = nil
-- theme.snap_border_width = nil
-- theme.snap_shape = nil

-- systray
-- theme.systray_icon_spacing = nil

-- taglist
theme.taglist_fg_focus = theme.wibar_fg
theme.taglist_bg_focus = theme.wibar_bg
-- theme.taglist_disable_icon = true
-- theme.taglist_fg_urgent = colors.fg
-- theme.taglist_bg_urgent = colors.red
-- theme.taglist_fg_occupied = colors.fg
-- theme.taglist_bg_occupied = colors.yellow
-- theme.taglist_fg_empty = colors.bg
-- theme.taglist_bg_empty = colors.bg
-- theme.taglist_bg_volatile = nil
-- theme.taglist_fg_volatile = nil
-- theme.taglist_squares_sel = nil
-- theme.taglist_squares_unsel = nil
-- theme.taglist_squares_sel_empty = nil
-- theme.taglist_squares_unsel_empty = nil
-- theme.taglist_squares_resize = nil
-- theme.taglist_font = nil
-- theme.taglist_spacing = nil
-- theme.taglist_shape = nil
-- theme.taglist_shape_border_width = nil
-- theme.taglist_shape_border_color = nil
-- theme.taglist_shape_empty = nil
-- theme.taglist_shape_border_width_empty = nil
-- theme.taglist_shape_border_color_empty = nil
-- theme.taglist_shape_focus = nil
-- theme.taglist_shape_border_width_focus = nil
-- theme.taglist_shape_border_color_focus = nil
-- theme.taglist_shape_urgent = nil
-- theme.taglist_shape_border_width_urgent = nil
-- theme.taglist_shape_border_color_urgent = nil
-- theme.taglist_shape_volatile = nil
-- theme.taglist_shape_border_width_volatile = nil
-- theme.taglist_shape_border_color_volatile = nil

-- tasklist
theme.tasklist_plain_task_name = true
theme.tasklist_disable_icon = true
theme.tasklist_disable_task_name = true
-- theme.tasklist_fg_normal = nil
-- theme.tasklist_bg_normal = nil
-- theme.tasklist_fg_focus = nil
-- theme.tasklist_bg_focus = nil
-- theme.tasklist_fg_urgent = nil
-- theme.tasklist_bg_urgent = nil
-- theme.tasklist_fg_minimize = nil
-- theme.tasklist_bg_minimize = nil
-- theme.tasklist_bg_image_normal = nil
-- theme.tasklist_bg_image_focus = nil
-- theme.tasklist_bg_image_urgent = nil
-- theme.tasklist_bg_image_minimize = nil
-- theme.tasklist_font = nil
-- theme.tasklist_align = nil
-- theme.tasklist_font_focus = nil
-- theme.tasklist_font_minimized = nil
-- theme.tasklist_font_urgent = nil
-- theme.tasklist_spacing = nil
-- theme.tasklist_shape = nil
-- theme.tasklist_shape_border_width = nil
-- theme.tasklist_shape_border_color = nil
-- theme.tasklist_shape_focus = nil
-- theme.tasklist_shape_border_width_focus = nil
-- theme.tasklist_shape_border_color_focus = nil
-- theme.tasklist_shape_minimized = nil
-- theme.tasklist_shape_border_width_minimized = nil
-- theme.tasklist_shape_border_color_minimized = nil
-- theme.tasklist_shape_urgent = nil
-- theme.tasklist_shape_border_width_urgent = nil
-- theme.tasklist_shape_border_color_urgent = nil

colors.transparent = '#00000000'

-- titlebar
theme.titlebar_size = dpi(10)
theme.titlebar_position = 'bottom'
theme.titlebar_fg_normal = colors.white
theme.titlebar_bg_normal = colors.white
theme.titlebar_fg = colors.white
theme.titlebar_bg = colors.white
theme.titlebar_fg_focus = colors.cyan
theme.titlebar_bg_focus = colors.cyan
-- theme.titlebar_bgimage_normal = nil
-- theme.titlebar_bgimage = nil
-- theme.titlebar_bgimage_focus = nil
-- theme.titlebar_floating_button_normal = nil
-- theme.titlebar_maximized_button_normal = nil
-- theme.titlebar_minimize_button_normal = nil
-- theme.titlebar_minimize_button_normal_hover = nil
-- theme.titlebar_minimize_button_normal_press = nil
-- theme.titlebar_close_button_normal = nil
-- theme.titlebar_close_button_normal_hover = nil
-- theme.titlebar_close_button_normal_press = nil
-- theme.titlebar_ontop_button_normal = nil
-- theme.titlebar_sticky_button_normal = nil
-- theme.titlebar_floating_button_focus = nil
-- theme.titlebar_maximized_button_focus = nil
-- theme.titlebar_minimize_button_focus = nil
-- theme.titlebar_minimize_button_focus_hover = nil
-- theme.titlebar_minimize_button_focus_press = nil
-- theme.titlebar_close_button_focus = nil
-- theme.titlebar_close_button_focus_hover = nil
-- theme.titlebar_close_button_focus_press = nil
-- theme.titlebar_ontop_button_focus = nil
-- theme.titlebar_sticky_button_focus = nil
-- theme.titlebar_floating_button_normal_active = nil
-- theme.titlebar_floating_button_normal_active_hover = nil
-- theme.titlebar_floating_button_normal_active_press = nil
-- theme.titlebar_maximized_button_normal_active = nil
-- theme.titlebar_maximized_button_normal_active_hover = nil
-- theme.titlebar_maximized_button_normal_active_press = nil
-- theme.titlebar_ontop_button_normal_active = nil
-- theme.titlebar_ontop_button_normal_active_hover = nil
-- theme.titlebar_ontop_button_normal_active_press = nil
-- theme.titlebar_sticky_button_normal_active = nil
-- theme.titlebar_sticky_button_normal_active_hover = nil
-- theme.titlebar_sticky_button_normal_active_press = nil
-- theme.titlebar_floating_button_focus_active = nil
-- theme.titlebar_floating_button_focus_active_hover = nil
-- theme.titlebar_floating_button_focus_active_press = nil
-- theme.titlebar_maximized_button_focus_active = nil
-- theme.titlebar_maximized_button_focus_active_hover = nil
-- theme.titlebar_maximized_button_focus_active_press = nil
-- theme.titlebar_ontop_button_focus_active = nil
-- theme.titlebar_ontop_button_focus_active_hover = nil
-- theme.titlebar_ontop_button_focus_active_press = nil
-- theme.titlebar_sticky_button_focus_active = nil
-- theme.titlebar_sticky_button_focus_active_hover = nil
-- theme.titlebar_sticky_button_focus_active_press = nil
-- theme.titlebar_floating_button_normal_inactive = nil
-- theme.titlebar_floating_button_normal_inactive_hover = nil
-- theme.titlebar_floating_button_normal_inactive_press = nil
-- theme.titlebar_maximized_button_normal_inactive = nil
-- theme.titlebar_maximized_button_normal_inactive_hover = nil
-- theme.titlebar_maximized_button_normal_inactive_press = nil
-- theme.titlebar_ontop_button_normal_inactive = nil
-- theme.titlebar_ontop_button_normal_inactive_hover = nil
-- theme.titlebar_ontop_button_normal_inactive_press = nil
-- theme.titlebar_sticky_button_normal_inactive = nil
-- theme.titlebar_sticky_button_normal_inactive_hover = nil
-- theme.titlebar_sticky_button_normal_inactive_press = nil
-- theme.titlebar_floating_button_focus_inactive = nil
-- theme.titlebar_floating_button_focus_inactive_hover = nil
-- theme.titlebar_floating_button_focus_inactive_press = nil
-- theme.titlebar_maximized_button_focus_inactive = nil
-- theme.titlebar_maximized_button_focus_inactive_hover = nil
-- theme.titlebar_maximized_button_focus_inactive_press = nil
-- theme.titlebar_ontop_button_focus_inactive = nil
-- theme.titlebar_ontop_button_focus_inactive_hover = nil
-- theme.titlebar_ontop_button_focus_inactive_press = nil
-- theme.titlebar_sticky_button_focus_inactive = nil
-- theme.titlebar_sticky_button_focus_inactive_hover = nil
-- theme.titlebar_sticky_button_focus_inactive_press = nil

-- tooltip
-- theme.tooltip_border_color = nil
-- theme.tooltip_bg = nil
-- theme.tooltip_fg = nil
-- theme.tooltip_font = nil
-- theme.tooltip_border_width = nil
-- theme.tooltip_opacity = nil
-- theme.tooltip_shape = nil
-- theme.tooltip_align = nil



return theme
