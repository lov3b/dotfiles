local wezterm = require("wezterm")

local config = {}

local function scheme_for_appearance(appearance)
	if appearance:find("Dark") then
		return "Catppuccin Mocha"
	end
	return "Catppuccin Latte"
end

local theme_path = wezterm.config_dir .. "/theme.lua"
local theme_ok, theme = pcall(dofile, theme_path)

local appearance = "Dark"
if wezterm.gui and wezterm.gui.get_appearance then
	appearance = wezterm.gui.get_appearance()
end

if theme_ok and type(theme) == "table" and theme.color_scheme and theme.force == true then
	config.color_scheme = theme.color_scheme
else
	config.color_scheme = scheme_for_appearance(appearance)
end
config.font_size = 14.0
config.scrollback_lines = 10000
config.keys = {
	{ key = "F11", action = wezterm.action.ToggleFullScreen },
}

return config
