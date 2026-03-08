#!/usr/bin/env sh

SCRIPT_DIR="$(dirname "$(realpath "$0")")"

"$SCRIPT_DIR/waybar/restart.sh"
"$SCRIPT_DIR/swaync/restart.sh"
