-- Autostart

hl.on("hyprland.start", function()
	-- PolicyKit
	hl.exec_cmd("/usr/libexec/polkit-gnome-authentication-agent-1")
	-- Notification daemon
	hl.exec_cmd("swaync")
	-- Idle management
	hl.exec_cmd("swayidle")
	-- Clipboard history
	hl.exec_cmd("wl-paste --watch cliphist store")
	-- Wallpaper
	hl.exec_cmd("swaybg -i /storage/media/images/Wallpapers/116912166_p0.png -m fill")
	-- Input method
	hl.exec_cmd("fcitx5 -r")
	-- Network
	hl.exec_cmd("nm-applet")
	-- Bluetooth
	hl.exec_cmd("blueman-applet")
	-- Status bar
	hl.exec_cmd("waybar -c ~/.config/waybar/config.hyprland.jsonc")
end)
