local config = require("config")
local keyboard = config.keyboard

hl.config({
	input = {
		kb_layout = keyboard.layout,
		follow_mouse = 1,
		sensitivity = 0,
		touchpad = {
			natural_scroll = false,
		},
	},
})
