-- Input

hl.config({
	input = {
		kb_layout = "us",
		kb_options = "numlock:1",
		follow_mouse = 2,
		sensitivity = 0,
		touchpad = {
			natural_scroll = true,
		},
	},
	cursor = {
		no_warps = true,
		warp_on_change_workspace = 0,
	},
	misc = {
		mouse_move_focuses_monitor = false,
	},
})

-- Gestures
hl.gesture({
	fingers = 3,
	direction = "horizontal",
	action = "workspace",
})

-- Device example (placeholder — see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Devices/)
-- hl.device({
-- 	name = "epic-mouse-v1",
-- 	sensitivity = -0.5,
-- })
