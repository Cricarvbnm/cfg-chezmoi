-- Keybindings
--
-- Key name reference (xkbcommon):
--   Modifier:   SUPER | SHIFT | CTRL | ALT
--   Navigation: left | right | up | down | Home | End | Page_Up | Page_Down
--   Editing:    BackSpace | Delete | Insert | Tab | Return | space | Escape
--   Function:   F1-F12 | Print | Pause | Scroll_Lock
--   Symbol:     grave(`) | minus(-) | equal(=) | bracketleft([) | bracketright(])
--               semicolon(;) | apostrophe(') | comma(,) | period(.) | slash(/)
--               backslash(\) | Caps_Lock | Num_Lock
--   Media:      XF86Audio{RaiseVolume,LowerVolume,Mute,MicMute,Play,Stop,Prev,Next}
--               XF86MonBrightness{Up,Down} | XF86Sleep | XF86PowerOff
--   Mouse:      mouse_up | mouse_down | mouse:272(LMB) | mouse:273(RMB) | mouse:274(MMB)
--   Full list:  see docs/xkbcommon-keysyms.h
--   Mouse:      mouse_up | mouse_down | mouse:272(LMB) | mouse:273(RMB) | mouse:274(MMB)

local mainMod = "SUPER"

-- ── Launch ──
hl.bind(mainMod .. " + T", hl.dsp.exec_cmd("kitty"))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd("nemo"))
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd("firefox"))
hl.bind("ALT + space", hl.dsp.exec_cmd("fuzzel"))

-- ── Lock screen ──
hl.bind(mainMod .. " + Escape", hl.dsp.exec_cmd("lock-and-dim"))

-- ── Clipboard manager ──
hl.bind(mainMod .. " + V", hl.dsp.exec_cmd('cliphist list | fuzzel --dmenu --prompt="  " | cliphist decode | wl-copy'))

-- ── Volume (PipeWire) ──
hl.bind(
	"XF86AudioRaiseVolume",
	hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioLowerVolume",
	hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioMute",
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioMicMute",
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
	{ locked = true, repeating = true }
)

-- ── Media (playerctl) ──
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })
hl.bind("XF86AudioStop", hl.dsp.exec_cmd("playerctl stop"), { locked = true })

-- ── Brightness ──
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), { locked = true, repeating = true })

-- ── Notifications ──
hl.bind(mainMod .. " + N", hl.dsp.exec_cmd("swaync-client -t"))
hl.bind(mainMod .. " + SHIFT + N", hl.dsp.exec_cmd("swaync-client -d"))

-- ── Window management ──
hl.bind(mainMod .. " + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + F11", hl.dsp.window.fullscreen())
hl.bind(mainMod .. " + F", hl.dsp.window.float({ action = "toggle" }))

-- ── Focus (arrows + HJKL) ──
hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "down" }))
hl.bind(mainMod .. " + H", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + J", hl.dsp.focus({ direction = "down" }))
hl.bind(mainMod .. " + K", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "right" }))

-- ── Move windows (arrows + HJKL) ──
hl.bind(mainMod .. " + SHIFT + left", hl.dsp.window.move({ direction = "l" }))
hl.bind(mainMod .. " + SHIFT + right", hl.dsp.window.move({ direction = "r" }))
hl.bind(mainMod .. " + SHIFT + up", hl.dsp.window.move({ direction = "u" }))
hl.bind(mainMod .. " + SHIFT + down", hl.dsp.window.move({ direction = "d" }))
hl.bind(mainMod .. " + SHIFT + H", hl.dsp.window.move({ direction = "l" }))
hl.bind(mainMod .. " + SHIFT + J", hl.dsp.window.move({ direction = "d" }))
hl.bind(mainMod .. " + SHIFT + K", hl.dsp.window.move({ direction = "u" }))
hl.bind(mainMod .. " + SHIFT + L", hl.dsp.window.move({ direction = "r" }))

-- ── Workspaces 1-9 ──
for i = 1, 9 do
	hl.bind(mainMod .. " + " .. i, hl.dsp.focus({ workspace = i }))
	hl.bind(mainMod .. " + SHIFT + " .. i, hl.dsp.window.move({ workspace = i }))
end

-- ── Workspace scroll ──
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "r+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "r-1" }))
hl.bind(mainMod .. " + SHIFT + mouse_down", hl.dsp.window.move({ workspace = "r+1" }))
hl.bind(mainMod .. " + SHIFT + mouse_up", hl.dsp.window.move({ workspace = "r-1" }))

-- ── Workspace navigation (keyboard) ──
hl.bind(mainMod .. " + CTRL + H", hl.dsp.focus({ workspace = "r-1" }))
hl.bind(mainMod .. " + CTRL + L", hl.dsp.focus({ workspace = "r+1" }))
hl.bind(mainMod .. " + CTRL + SHIFT + H", hl.dsp.window.move({ workspace = "r-1" }))
hl.bind(mainMod .. " + CTRL + SHIFT + L", hl.dsp.window.move({ workspace = "r+1" }))

-- ── Mouse drag & resize ──
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- ── Screenshots (requires hyprshot + hyprpicker) ──
hl.bind("Print", hl.dsp.exec_cmd("hyprshot --mode output --mode active"))
hl.bind("CTRL + Print", hl.dsp.exec_cmd("hyprshot --mode region --freeze"))
hl.bind("SHIFT + Print", hl.dsp.exec_cmd("hyprshot --mode window --mode active"))

-- ── Session ──
hl.bind(mainMod .. " + SHIFT + E", hl.dsp.exit())
hl.bind("CTRL + ALT + Delete", hl.dsp.exit())
hl.bind(mainMod .. " + SHIFT + P", hl.dsp.exec_cmd([[sleep 0.5 && hyprctl dispatch 'hl.dsp.dpms("off")']]))

-- ── Shutdown menu ──
-- Requires hyprshutdown — install before uncommenting
hl.bind(
	"CTRL + ALT + Escape",
	hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch exit")
)

-- ── Dwindle: toggle split direction ──
hl.bind(mainMod .. " + O", hl.dsp.layout("togglesplit"))

-- ═══════════════════════════════════════════════════════════
-- Explore — features under evaluation
-- ═══════════════════════════════════════════════════════════

-- Pseudo tile (dwindle)
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())

-- Group (tab-like window groups)
hl.bind(mainMod .. " + S", hl.dsp.group.toggle())
hl.bind(mainMod .. " + BracketLeft", hl.dsp.group.prev())
hl.bind(mainMod .. " + BracketRight", hl.dsp.group.next())

-- Magic workspace (scratchpad)
hl.bind(mainMod .. " + grave", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + grave", hl.dsp.window.move({ workspace = "special:magic" }))

-- TODO: overview (needs hyprexpo plugin)
hl.bind(mainMod .. " + W", function()
	hl.plugin.hyprexpo.expo("toggle")
end)
