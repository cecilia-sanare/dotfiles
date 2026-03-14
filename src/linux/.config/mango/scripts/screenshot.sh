#!/usr/bin/env sh

error() {
  echo "Error: $1" >&2
  notify-send "Error" "$1"
}

# Check dependencies
command -v wayfreeze > /dev/null || { error "wayfreeze is not installed. Please install it to take screenshots."; exit 1; }
command -v slurp > /dev/null || { error "slurp is not installed. Please install it to select a screen region."; exit 1; }
command -v wl-copy > /dev/null || { error "wl-copy is not installed. Please install wl-clipboard to copy to clipboard."; exit 1; }

# Platform check
if [ "$(uname -s)" != "Linux" ] || ! command -v wayland-scanner > /dev/null; then
  error "This script only works on Linux with Wayland. Your current environment is not supported."
  exit 1
fi

TYPE="${1:-region}"

case $TYPE in
  screen)
    wayfreeze --after-freeze-cmd 'grim -g "$(slurp -o)" - | wl-copy; killall wayfreeze'
    ;;
  region)
    wayfreeze --after-freeze-cmd 'grim -g "$(slurp)" - | wl-copy; killall wayfreeze'
    ;;
  *)
    error "Unknown screenshot type '$TYPE'. Valid options are 'screen' (full screen) or 'region' (select area)."
    exit 1
esac || { error "Screenshot failed. Make sure your display server is running and try again."; exit 1; }

notify-send "Screenshot" "Saved to clipboard"
