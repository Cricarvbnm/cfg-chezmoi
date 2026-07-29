-- Monitors

-- Laptop screen (eDP-1) — uncomment when docked
-- hl.monitor({
-- 	output = "eDP-1",
-- 	mode = "1920x1080@120.030",
-- 	scale = 1.5,
-- })

-- My Virtual Monitor
hl.monitor({
	output = "HDMI-A-3",
	mode = "1920x1080@60",
	scale = 1.33,
})

hl.workspace_rule({ workspace = "9", monitor = "desc:BBC HDP-V104 demoset-1", default = true })

-- Xwayland scaling
hl.config({
	xwayland = {
		force_zero_scaling = true,
	},
})

-- X toolkit-specific scale
hl.env("GDK_SCALE", "2")
