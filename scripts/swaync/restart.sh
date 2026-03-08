#!/usr/bin/env sh

set +e

$(pwd)/scripts/sass.sh
pkill swaync && swaync >/dev/null 2>&1 &

sleep 1

notify-send "test"
notify-send --urgency=critical --icon="$HOME/.config/mango/assets/mango.png" "Mango Status" "test"
