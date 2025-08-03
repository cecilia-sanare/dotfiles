#!/usr/bin/env sh

bunx sass \
  --no-source-map --no-error-css \
  ${PWD}/styles/waybar/index.scss:${PWD}/.config/waybar/style.css \
  ${PWD}/styles/wofi/index.scss:${PWD}/.config/wofi/style.css \
  ${PWD}/styles/swaync/index.scss:${PWD}/.config/swaync/style.css $@
