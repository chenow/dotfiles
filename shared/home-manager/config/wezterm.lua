local wezterm = require("wezterm")

local config = wezterm.config_builder()
local act = wezterm.action

config.color_scheme = "Catppuccin Mocha"
config.window_close_confirmation = "NeverPrompt"
config.native_macos_fullscreen_mode = true
config.hide_tab_bar_if_only_one_tab = true
config.default_cwd = "/Users/chenow/Documents/git"
config.front_end = "WebGpu" -- to remove when the bug is fixed: https://github.com/wez/wezterm/issues/5990
config.hide_mouse_cursor_when_typing = false

config.keys = {
	{ key = "L", mods = "ALT|SHIFT", action = wezterm.action({ SendString = "|" }) },
	{ key = "%", mods = "CTRL|SHIFT|ALT", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
	{ key = "£", mods = "CTRL|SHIFT|ALT", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
	{ key = "n", mods = "ALT", action = wezterm.action({ SendString = "~" }) },
}

return config
