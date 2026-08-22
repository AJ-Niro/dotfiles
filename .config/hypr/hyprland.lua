local config = require("config")
local apps = config.apps
local workspaces = config.workspaces

------------------
---- MONITORS ----
------------------

-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
hl.monitor({
	output = "",
	mode = "preferred",
	position = "auto",
	scale = "1.33",
})

-------------------
---- AUTOSTART ----
-------------------

-- See https://wiki.hypr.land/Configuring/Basics/Autostart/

-- Autostart necessary processes (like notifications daemons, status bars, etc.)
-- Or execute your favorite apps at launch like this:
--
hl.on("hyprland.start", function()
	hl.exec_cmd(apps.quickshell)
	hl.dispatch(hl.dsp.focus({ workspace = workspaces.default }))
	hl.exec_cmd(apps.terminal)
	--   hl.exec_cmd("nm-applet")
	--   hl.exec_cmd("waybar & hyprpaper & firefox")
	-- hl.exec_cmd("waybar & hyprpaper")
end)

-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Environment-variables/

hl.env("XCURSOR_SIZE", "20")
hl.env("HYPRCURSOR_SIZE", "20")

-----------------------
----- PERMISSIONS -----
-----------------------

-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Permissions/
-- Please note permission changes here require a Hyprland restart and are not applied on-the-fly
-- for security reasons

-- hl.config({
--   ecosystem = {
--     enforce_permissions = true,
--   },
-- })

-- hl.permission("/usr/(bin|local/bin)/grim", "screencopy", "allow")
-- hl.permission("/usr/(lib|libexec|lib64)/xdg-desktop-portal-hyprland", "screencopy", "allow")
-- hl.permission("/usr/(bin|local/bin)/hyprpm", "plugin", "allow")

-----------------------
---- LOOK AND FEEL ----
-----------------------

require("animation")

-- See https://wiki.hypr.land/Configuring/Layouts/Dwindle-Layout/ for more

hl.config({
	general = {
		layout = "monocle",
	},
})

hl.config({
	dwindle = {
		preserve_split = true, -- You probably want this
	},
})

----------------
----  MISC  ----
----------------

hl.config({
	misc = {
		force_default_wallpaper = -1, -- Set to 0 or 1 to disable the anime mascot wallpapers
		disable_hyprland_logo = true, -- If true disables the random hyprland logo / anime girl background. :(
	},
})

---------------
---- INPUT ----
---------------

require("input")

---------------------
---- KEYBINDINGS ----
---------------------

require("keybinding")

--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

require("windows")
