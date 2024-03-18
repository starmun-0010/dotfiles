local wezterm = require 'wezterm'
local config = wezterm.config_builder() 

--Appearance
config.color_scheme = 'Catppuccin Frappe'
config.window_background_opacity = 0.8
config.hide_tab_bar_if_only_one_tab = true
config.audible_bell = 'Disabled' 
config.initial_cols = 126

--Startup program
config.default_prog = { 'nu' }

--Mux
config.quit_when_all_windows_are_closed = false
config.unix_domains = {
    {
        name ='unix'
    },
    {
        name ='temp'
    }

}
config.default_gui_startup_args = { 'connect', 'unix' }


local act = wezterm.action

wezterm.on('update-right-status', function(window, pane)
  window:set_right_status(window:active_workspace())
end)

config.keys = {
  -- Prompt for a name to use for a new workspace and switch to it.
  {
    key = 'W',
    mods = 'CTRL|SHIFT',
    action = act.PromptInputLine {
      description = wezterm.format {
        { Attribute = { Intensity = 'Bold' } },
        { Foreground = { AnsiColor = 'Fuchsia' } },
        { Text = 'Enter name for new workspace' },
      },
      action = wezterm.action_callback(function(window, pane, line)
        -- line will be `nil` if they hit escape without entering anything
        -- An empty string if they just hit enter
        -- Or the actual line of text they wrote
        if line then
          window:perform_action(
            act.SwitchToWorkspace {
              name = line,
            },
            pane
          )
        end
      end),
    },
  },
}


return config
