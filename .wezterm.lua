local wezterm = require("wezterm")

local config = wezterm.config_builder()

config.font_size = 13

config.font = wezterm.font("Hack Nerd Font")

config.color_scheme = "Tokyo Night"

config.enable_tab_bar = false

config.window_padding = {
	left = "0.5cell",
	right = "0.5cell",
	top = "0.25cell",
	bottom = "0.25cell",
}

return config
