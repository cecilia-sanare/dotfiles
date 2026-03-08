#!/usr/bin/bash

# Change brightness level with `light`.
# You can call this script like this:
# brightness.sh [up|down]

function get_brightness {
	var=$(brightnessctl get)
	echo "${var##* }" | sed 's/[^0-9][^.]*//g'
}

case $1 in
up)
	swayosd-client --brightness +2
	;;
down)
	swayosd-client --brightness -2
	;;
esac
