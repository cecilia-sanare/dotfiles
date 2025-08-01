#!/usr/bin/env bash

readarray -t DEVICES < <(
  bluetoothctl devices Connected |
  grep '^Device' |
  sed -E 's/^Device ([A-F0-9:]+) (.+)$/\2/'
)

DEVICE_COUNT=${#DEVICES[@]}
TOOLTIP=""

if [ $DEVICE_COUNT -gt 1 ]; then
  TEXT="${DEVICE_COUNT} Connected"

  for DEVICE in $DEVICES; do
    TOOLTIP+="$DEVICE\n"
  done

  TOOLTIP="${TOOLTIP::-2}"
else
  TEXT=$DEVICES
fi

cat <<EOF
  {"text":"<b>${TEXT}</b>","tooltip":"$TOOLTIP"}
EOF



