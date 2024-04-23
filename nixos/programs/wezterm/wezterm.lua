local wezterm = require 'wezterm'
local config = wezterm.config_builder() 

config.enable_wayland = false
config.front_end = "WebGpu"

--Appearance
config.color_scheme = 'Catppuccin Mocha'
config.window_background_opacity = 0.8
config.hide_tab_bar_if_only_one_tab = true
config.audible_bell = 'Disabled' 
config.initial_cols = 126

--Startup program
config.default_prog = { 'zellij' }

return config
