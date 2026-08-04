-- Style: appearance, animations, misc

-- ── Look and Feel ──
hl.config({
	general = {
		gaps_in = 5,
		gaps_out = 20,
		border_size = 2,
		col = {
			active_border = { colors = { "rgba(33ccffee)", "rgba(00ff99ee)" }, angle = 45 },
			inactive_border = "rgba(595959aa)",
		},
		resize_on_border = false,
		allow_tearing = false,
		layout = "dwindle",
	},
	decoration = {
		rounding = 10,
		rounding_power = 2,
		active_opacity = 1.0,
		inactive_opacity = 1.0,
		shadow = {
			enabled = true,
			range = 4,
			render_power = 3,
			color = 0xee1a1a1a,
		},
		blur = {
			enabled = true,
			size = 3,
			passes = 1,
			vibrancy = 0.1696,
		},
	},
	animations = {
		enabled = true,
	},
	misc = {
		force_default_wallpaper = -1,
		disable_hyprland_logo = false,
	},
})

hl.env("HYPRCURSOR_THEME", "Nordzy-hyprcursors-catppuccin-macchiato-sky")
hl.env("HYPRCURSOR_SIZE", "28")
hl.env("CURSOR_THEME", "Nordzy-catppuccin-macchiato-sky")
hl.env("CURSOR_SIZE", "28")

-- ── Animation Curves ──
-- Material Design curves (from end-4/dots-hyprland, 15K stars)
hl.curve("emphasizedDecel", { type = "bezier", points = { { 0.05, 0.7 }, { 0.1, 1.0 } } })
hl.curve("emphasizedAccel", { type = "bezier", points = { { 0.3, 0.0 }, { 0.8, 0.15 } } })
hl.curve("menuDecel", { type = "bezier", points = { { 0.1, 1.0 }, { 0.0, 1.0 } } })
hl.curve("standardDecel", { type = "bezier", points = { { 0.0, 0.0 }, { 0.0, 1.0 } } })

-- ── Animations ──
hl.animation({ leaf = "global", enabled = true, speed = 5.0, bezier = "standardDecel" })
hl.animation({ leaf = "border", enabled = true, speed = 5.0, bezier = "emphasizedDecel" })
hl.animation({ leaf = "windows", enabled = true, speed = 5.0, bezier = "emphasizedDecel", style = "slide" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 5.0, bezier = "emphasizedDecel", style = "slide" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 3.0, bezier = "emphasizedAccel", style = "slide" })
hl.animation({ leaf = "windowsMove", enabled = true, speed = 5.0, bezier = "emphasizedDecel", style = "slide" })
hl.animation({ leaf = "fadeIn", enabled = true, speed = 3.0, bezier = "emphasizedDecel" })
hl.animation({ leaf = "fadeOut", enabled = true, speed = 2.5, bezier = "emphasizedAccel" })
hl.animation({ leaf = "fade", enabled = true, speed = 4.0, bezier = "emphasizedDecel" })
hl.animation({ leaf = "layers", enabled = true, speed = 5.0, bezier = "emphasizedDecel" })
hl.animation({ leaf = "layersIn", enabled = true, speed = 5.0, bezier = "emphasizedDecel", style = "fade" })
hl.animation({ leaf = "layersOut", enabled = true, speed = 3.0, bezier = "emphasizedAccel", style = "fade" })
hl.animation({ leaf = "fadeLayersIn", enabled = true, speed = 2.5, bezier = "emphasizedDecel" })
hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 2.5, bezier = "emphasizedAccel" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 7.0, bezier = "menuDecel", style = "slide" })
hl.animation({ leaf = "workspacesIn", enabled = true, speed = 7.0, bezier = "menuDecel", style = "slide" })
hl.animation({ leaf = "workspacesOut", enabled = true, speed = 7.0, bezier = "menuDecel", style = "slide" })
hl.animation({ leaf = "zoomFactor", enabled = true, speed = 5.0, bezier = "standardDecel" })
