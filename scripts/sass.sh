#!/usr/bin/env sh

bunx sass \
  --no-source-map --no-error-css \
  ${PWD}/styles/waybar/index.scss:${PWD}/src/.config/waybar/style.css \
  ${PWD}/styles/wofi/index.scss:${PWD}/src/.config/wofi/style.css \
  ${PWD}/styles/swaync/index.scss:${PWD}/src/.config/swaync/style.css $@
