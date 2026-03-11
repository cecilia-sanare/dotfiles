#!/bin/bash

set +e

gsettings set org.gnome.desktop.interface gtk-theme "Adwaita-dark"   # for GTK3 apps
gsettings set org.gnome.desktop.interface color-scheme "prefer-dark"   # for GTK4 apps

# notify
swaync >/dev/null 2>&1 &

# wallpaper
waypaper --restore

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

1password --silent >/dev/null 2>&1 &

# start goxlr-daemon only if not already running
if ! pgrep -x "goxlr-daemon" >/dev/null 2>&1; then
    goxlr-daemon >/dev/null 2>&1 &
fi
