local wezterm = require 'wezterm'

local config = wezterm.config_builder()
local act = wezterm.action

config.color_scheme = 'Catppuccin Mocha'
config.window_close_confirmation = 'NeverPrompt'
config.native_macos_fullscreen_mode = true
config.hide_tab_bar_if_only_one_tab = true
config.default_cwd = "/Users/chenow/Documents/git"

config.keys = {
    { key = "L", mods = "ALT|SHIFT",      action = wezterm.action { SendString = "|" } },
    { key = "`", mods = "ALT|CTRL|SHIFT", action = act.SplitVertical { domain = 'CurrentPaneDomain' } },
    { key = "ù", mods = "ALT|CTRL|SHIFT", action = act.SplitHorizontal { domain = 'CurrentPaneDomain' } },
}

return config
