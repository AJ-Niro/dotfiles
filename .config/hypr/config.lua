return {
	-- HOME ROW WORKSPACES
	workspaces = {
		names = { "a", "s", "d", "f", "j", "k", "l", "semicolon" },
		default = 5,
	},

	layouts = {
		order = { "monocle", "dwindle" },
		dwindle = {},
		monocle = {},
	},

	-- KEYBOARD
	keyboard = {
		layout = "us",
		keys = {
			main_mod = "SUPER", -- Sets "Windows" key as main modifier
		},
	},

	-- APPLICATIONS
	apps = {
		terminal = "kitty",
		quickshell = "qs",
		file_manager = "nautilus",
		launcher = "rofi -show run",
	},

	-- SYSTEM CONTROLS
	system_controls = {
		shutdown = "command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'",
		audio = {
			raise_volume = "wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+",
			lower_volume = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-",
			mute = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle",
		},
		mic = {
			mute = "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle",
		},
		brightness = {
			up = "brightnessctl -e4 -n2 set 5%+",
			down = "brightnessctl -e4 -n2 set 5%-",
		},
		playback = {
			next = "playerctl next",
			previous = "playerctl previous",
			play_pause = "playerctl play-pause",
		},
	},
}
