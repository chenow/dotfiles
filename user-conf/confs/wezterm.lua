local wezterm = require 'wezterm'
local mux = wezterm.mux

local config = wezterm.config_builder()

config.color_scheme = 'Catppuccin Mocha'
config.window_close_confirmation = 'NeverPrompt'
config.native_macos_fullscreen_mode = true
config.hide_tab_bar_if_only_one_tab = true
config.default_cwd = "/Users/chenow/Documents/git"

wezterm.on("gui-startup", function()
  local tab, pane, window = mux.spawn_window(cmd or {})
  window:gui_window():toggle_fullscreen()
end)

return config
