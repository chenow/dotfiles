local config = {}
local act = wezterm.action

-- Use default rules but replace the catch-all to not include ) or ] in URLs.
-- The default catch-all is: \b\w+://\S+[)/a-zA-Z0-9-]+
-- which grabs trailing ) from markdown (URL) syntax.
-- We replace it with a version that excludes ) and ] from the final character class.
-- Ref: https://wezterm.org/config/lua/config/hyperlink_rules.html
config.hyperlink_rules = wezterm.default_hyperlink_rules()
for i, rule in ipairs(config.hyperlink_rules) do
  if rule.regex == '\\b\\w+://\\S+[)/a-zA-Z0-9-]+' then
    config.hyperlink_rules[i] = {
      regex = [[\b\w+://\S+[/a-zA-Z0-9-]+]],
      format = '$0',
    }
    break
  end
end

-- Reconstruct URLs that CLI tools (e.g. kiro-cli) hard-wrap across lines.
-- Ref: https://wezterm.org/config/lua/window-events/open-uri.html
-- Ref: https://wezterm.org/config/lua/wezterm.url/Url.html
wezterm.on('open-uri', function(window, pane, uri)
  local text = pane:get_lines_as_text(pane:get_dimensions().viewport_rows)
  local escaped = uri:gsub('([%(%)%.%%%+%-%*%?%[%]%^%$])', '%%%1')
  local cont = text:match(escaped .. '\n(%S+)')
  if cont then
    -- Strip trailing markdown/punctuation that isn't part of the URL
    local full = uri .. cont:gsub('[%)%]%.,;:!%?]+$', '')
    -- Validate the reconstructed URL before opening
    local ok, parsed = pcall(wezterm.url.parse, full)
    if ok and parsed.scheme then
      wezterm.log_info('open-uri: reconstructed ' .. full)
      wezterm.open_with(full)
      return false
    end
  end
end)

config.color_scheme = "Catppuccin Mocha"
config.window_close_confirmation = "NeverPrompt"
config.native_macos_fullscreen_mode = true
config.hide_tab_bar_if_only_one_tab = true
config.front_end = "WebGpu" -- to remove when the bug is fixed: https://github.com/wez/wezterm/issues/5990
config.hide_mouse_cursor_when_typing = false

config.keys = {
	{ key = "L", mods = "ALT|SHIFT", action = wezterm.action({ SendString = "|" }) },
	{
		key = "%",
		mods = "CTRL|SHIFT|ALT",
		action = act.SplitVertical({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "£",
		mods = "CTRL|SHIFT|ALT",
		action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
	{ key = "n", mods = "ALT", action = wezterm.action({ SendString = "~" }) },
	{
		key = "LeftArrow",
		mods = "OPT",
		action = wezterm.action({ SendString = "\x1bb" }),
	}, -- Make Option-Right equivalent to Alt-f; forward-word
	{
		key = "RightArrow",
		mods = "OPT",
		action = wezterm.action({ SendString = "\x1bf" }),
	},
}
