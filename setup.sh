#!/usr/bin/env sh

CONFIG_DIRS=($(find "$(pwd)/.config" -mindepth 1 -maxdepth 1 -type d))

echo -n "Creating symbolic links to the config directories"

for CONFIG_DIR in "${CONFIG_DIRS[@]}"; do
  OUTPUT_DIR="$HOME/.config/$(basename $CONFIG_DIR)"

  if [ -d "$OUTPUT_DIR" ] && [ ! -L "$OUTPUT_DIR" ]; then
    rm -rf $OUTPUT_DIR
  fi

  ln -sfnT "$CONFIG_DIR" "$OUTPUT_DIR"
  echo -n "."
  sleep 0.01
done

echo " Done!"
