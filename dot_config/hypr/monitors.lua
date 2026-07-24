-- Monitors

-- Laptop screen (eDP-1) — uncomment when docked
-- hl.monitor({
-- 	output = "eDP-1",
-- 	mode = "1920x1080@120.030",
-- 	scale = 1.5,
-- })

hl.monitor({
	output = "HDMI-A-3",
	mode = "1920x1080@60",
	scale = 1.33,
})

-- DPMS wake on input
hl.config({
	misc = {
		key_press_enables_dpms = true,
		mouse_move_enables_dpms = true,
	},
})
