-- Layouts & Window Rules

hl.config({
	-- ── Misc ──
	misc = {
		focus_on_activate = true,
	},

	-- ── Dwindle ──
	dwindle = {
		preserve_split = true,
	},

	-- ── Master ──
	master = {
		new_status = "master",
	},

	-- ── Scrolling ──
	scrolling = {
		fullscreen_on_one_column = true,
	},
})

-- ── Window Rules ──

hl.window_rule({
	name = "suppress-maximize-events",
	match = { class = ".*" },
	suppress_event = "maximize",
})

hl.window_rule({
	name = "fix-xwayland-drags",
	match = {
		class = "^$",
		title = "^$",
		xwayland = true,
		float = true,
		fullscreen = false,
		pin = false,
	},
	no_focus = true,
})

hl.window_rule({
	name = "move-hyprland-run",
	match = { class = "hyprland-run" },
	move = "20 monitor_h-120",
	float = true,
})
