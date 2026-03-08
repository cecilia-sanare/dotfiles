#!/bin/bash

set +e

gsettings set org.gnome.desktop.interface gtk-theme "Adwaita-dark"   # for GTK3 apps
gsettings set org.gnome.desktop.interface color-scheme "prefer-dark"   # for GTK4 apps

# notify
swaync >/dev/null 2>&1 &

# wallpaper
swaybg -i "$(find ~/Pictures/wallpapers/ -type f | shuf -n 1 | xargs)" >/dev/null 2>&1 &

# top bar
waybar >/dev/null 2>&1 &

# xwayland dpi scale
echo "Xft.dpi: 140" | xrdb -merge # DPI Scaling

# keep clipboard content
wl-clip-persist --clipboard regular --reconnect-tries 0 >/dev/null 2>&1 &

# Permission authentication
/usr/lib/xfce-polkit/xfce-polkit >/dev/null 2>&1 &

# inhibit by audio
sway-audio-idle-inhibit >/dev/null 2>&1 &

# change light value and volume value by swayosd-client in keybind
swayosd-server >/dev/null 2>&1 &

1password --silent >/dev/null 2>&1  &
