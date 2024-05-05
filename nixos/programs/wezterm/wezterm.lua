local wezterm = require 'wezterm'
local config = wezterm.config_builder() 
config.front_end = "WebGpu"
config.enable_wayland = false

--Appearance
config.color_scheme = 'Catppuccin Mocha'
config.window_background_opacity = 0.8
config.hide_tab_bar_if_only_one_tab = true
config.audible_bell = 'Disabled' 
config.initial_cols = 126

--Startup program
config.default_prog = { 'zellij' }
config.keys = {
  {
    key = 'r',
    mods = 'CMD|SHIFT',
    action = wezterm.action.ReloadConfiguration,
  },
}

return config
