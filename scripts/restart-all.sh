#!/usr/bin/env sh

SCRIPT_DIR="$(dirname "$(realpath "$0")")"

"$SCRIPT_DIR/restart-hyprpaper.sh"
"$SCRIPT_DIR/restart-waybar.sh"