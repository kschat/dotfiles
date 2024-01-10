local wezterm = require 'wezterm';

local font_name = 'SauceCodePro Nerd Font';
-- local font_name = 'Source Code Pro';

local gruvbox_material_medium_dark = {
  foreground = '#d4be98',
  background = '#282828',
  cursor_bg = '#d4be98',
  cursor_border = '#d4be98',
  cursor_fg = '#282828',
  selection_bg = '#d4be98' ,
  selection_fg = '#282828',

  ansi = {
    '#3c3836',
    '#ea6962',
    '#a9b665',
    '#d8a657',
    '#7daea3',
    '#d3869b',
    '#89b482',
    '#d4be98',
  },
  brights = {
    '#3c3836',
    '#ea6962',
    '#a9b665',
    '#d8a657',
    '#7daea3',
    '#d3869b',
    '#89b482',
    '#d4be98',
  },
};

return {
  font = wezterm.font(font_name, { weight = 'DemiBold' }),
  font_size = 10.5,
  freetype_load_flags = 'NO_HINTING|NO_AUTOHINT',
  -- custom_block_glyphs = false,

  font_rules = {
    {
      italic = true,
      font = wezterm.font(font_name, { weight = 'DemiBold', style = 'Italic' }),
    },
    {
      intensity = 'Bold',
      font = wezterm.font(font_name, { weight = 'Bold' }),
    },
    {
      italic = true,
      intensity = 'Bold',
      font = wezterm.font(font_name, { weight = 'Bold', style = 'Italic' }),
    },
    {
      intensity = 'Half',
      font = wezterm.font(font_name, { weight = 'DemiBold' }),
    },
    -- {
    --   italic = true,
    --   intensity = 'Half',
    --   font = wezterm.font(font_name, { weight = 'DemiBold', style = 'Italic' }),
    -- },
  },

  color_scheme = 'gruvbox_material_medium_dark',
  color_schemes = {
    ['gruvbox_material_medium_dark'] = gruvbox_material_medium_dark,
  },
  colors = {
    tab_bar = {
      inactive_tab_edge = gruvbox_material_medium_dark.background,
      active_tab = {
        bg_color = gruvbox_material_medium_dark.background,
        fg_color = gruvbox_material_medium_dark.background,
      },
      inactive_tab = {
        bg_color = gruvbox_material_medium_dark.background,
        fg_color = gruvbox_material_medium_dark.background,
      },
      inactive_tab_hover = {
        bg_color = gruvbox_material_medium_dark.background,
        fg_color = gruvbox_material_medium_dark.background,
      },
      new_tab = {
        bg_color = gruvbox_material_medium_dark.background,
        fg_color = gruvbox_material_medium_dark.background,
      },
      new_tab_hover = {
        bg_color = gruvbox_material_medium_dark.background,
        fg_color = gruvbox_material_medium_dark.background,
      },
    },
  },
  window_frame = {
    active_titlebar_bg = gruvbox_material_medium_dark.background,
    inactive_titlebar_bg = gruvbox_material_medium_dark.background,
  },

  use_fancy_tab_bar = true,
  enable_wayland = true,
  window_close_confirmation = 'NeverPrompt',
  window_decorations = 'INTEGRATED_BUTTONS|RESIZE',
  integrated_title_button_style = 'Gnome',
  window_padding = {
    top = 2,
    left = 8,
    right = 8,
    bottom = 8,
  },
}
