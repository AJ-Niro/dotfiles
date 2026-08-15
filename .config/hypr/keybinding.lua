-- Example binds, see https://wiki.hypr.land/Configuring/Basics/Binds/ for more

local config = require("config")
local keys = config.keyboard.keys
local apps = config.apps
local workspaces = config.workspaces
local system_controls = config.system_controls

----------------------
----- WORKSPACES -----
----------------------

for i, key in ipairs(workspaces.names) do
	hl.bind(keys.main_mod .. " + " .. key, hl.dsp.focus({ workspace = i }))
	hl.bind(keys.main_mod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
	hl.workspace_rule({
		workspace = tostring(i),
		persistent = true,
		default = (i == workspaces.default),
	})
end

------------------------
----- APPLICATIONS -----
------------------------

hl.bind(keys.main_mod .. " + Q", hl.dsp.exec_cmd(apps.terminal))
hl.bind(keys.main_mod .. " + E", hl.dsp.exec_cmd(apps.file_manager))
hl.bind(keys.main_mod .. " + R", hl.dsp.exec_cmd(apps.launcher))

----------------------
------- SYSTEM -------
----------------------

-- Close Windows
local closeWindowBind = hl.bind(keys.main_mod .. " + C", hl.dsp.window.close())
closeWindowBind:set_enabled(true)

-- Shutdown System
hl.bind(keys.main_mod .. " + M", hl.dsp.exec_cmd(system_controls.shutdown))

-- Windows Layouts
hl.bind(keys.main_mod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(keys.main_mod .. " + P", hl.dsp.window.pseudo())
hl.bind(keys.main_mod .. " + W", hl.dsp.layout("togglesplit")) -- dwindle only

-- Move focus with keys.main_mod + arrow keys
hl.bind(keys.main_mod .. " + left", hl.dsp.focus({ direction = "left" }))
hl.bind(keys.main_mod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(keys.main_mod .. " + up", hl.dsp.focus({ direction = "up" }))
hl.bind(keys.main_mod .. " + down", hl.dsp.focus({ direction = "down" }))

-- Move/resize windows with keys.main_mod + LMB/RMB and dragging
hl.bind(keys.main_mod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(keys.main_mod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

------------------------------
----- LAPTOP MULTIMEDIA -----
------------------------------
hl.bind(
	"XF86AudioRaiseVolume",
	hl.dsp.exec_cmd(system_controls.audio.raise_volume),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioLowerVolume",
	hl.dsp.exec_cmd(system_controls.audio.lower_volume),
	{ locked = true, repeating = true }
)
hl.bind("XF86AudioMute", hl.dsp.exec_cmd(system_controls.audio.mute), { locked = true, repeating = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd(system_controls.mic.mute), { locked = true, repeating = true })

hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd(system_controls.brightness.up), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd(system_controls.brightness.down), { locked = true, repeating = true })

hl.bind("XF86AudioNext", hl.dsp.exec_cmd(system_controls.playback.next), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd(system_controls.playback.play_pause), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd(system_controls.playback.play_pause), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd(system_controls.playback.previous), { locked = true })
