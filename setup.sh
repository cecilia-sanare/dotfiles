#!/usr/bin/env sh

escape_path()
{
  echo $1 | sed -e "s/\//\\\\\//g"
}

OS=$(uname -s)
CURRENT_DIR="$(pwd)/src"

current_os_dir()
{
  DIRECTORY=""

  if [ "$OS" = "Linux" ]; then
    DIRECTORY="$CURRENT_DIR/linux"
  elif [ "$OS" = "Darwin" ]; then
    DIRECTORY="$CURRENT_DIR/macos"
  fi

  if [ ! -z "$DIRECTORY" ] && [ -d "$DIRECTORY" ]; then
    echo "$DIRECTORY"
  fi
}

get_base_dir()
{
  BASE_DIR=$1

  if [ ! -z "$CURRENT_OS_DIR" ]; then
    BASE_DIR=$(echo $BASE_DIR | sed -e "s/$(escape_path "$CURRENT_OS_DIR")//g")
  fi

  echo $BASE_DIR | sed -e "s/$(escape_path "$CURRENT_DIR")//g"
}

CURRENT_OS_DIR=`current_os_dir $OS`

CONFIG_DIRS=($(find "$CURRENT_DIR" -mindepth 1 -maxdepth 1 | grep -v "linux" | grep -v "macos" | grep -v "\.config"))
CONFIG_DIRS+=($(find "$CURRENT_DIR/.config" -mindepth 1 -maxdepth 1))

if [ ! -z "$CURRENT_OS_DIR" ]; then
  CONFIG_DIRS+=($(find $CURRENT_OS_DIR -mindepth 1 -maxdepth 1 | grep -v "\.config"))

  if [ -d "$CURRENT_OS_DIR/.config" ]; then
    CONFIG_DIRS+=($(find "$CURRENT_OS_DIR/.config" -mindepth 1 -maxdepth 1))
  fi
fi

printf "Creating symbolic links to the config directories"

for CONFIG_DIR in "${CONFIG_DIRS[@]}"; do
  BASE_DIR=$(get_base_dir $CONFIG_DIR)
  OUTPUT_DIR="$HOME$BASE_DIR"

  if [ -d "$OUTPUT_DIR" ] && [ ! -L "$OUTPUT_DIR" ]; then
    rm -rf $OUTPUT_DIR
  fi

  if [ "$OS" = "Darwin" ]; then
    ln -sfn "$CONFIG_DIR" "$OUTPUT_DIR"
  elif [ "$OS" = "Linux" ]; then
    ln -sfnT "$CONFIG_DIR" "$OUTPUT_DIR"
  else
    echo ". Error! Unsupported operating system!"
    exit 1
  fi

  printf "."
  sleep 0.01
done

echo " Done!"

# Setup default applications

if [ "$OS" = "Linux" ]; then
  printf "Setting up default apps..."
  # Setup Thunar as the default file browser
  if command -v thunar >/dev/null 2>&1; then
    xdg-mime default thunar.desktop inode/directory
  fi

  # Setup Zen as the default browser
  if command -v zen-browser >/dev/null 2>&1; then
    xdg-mime default zen.desktop x-scheme-handler/http
    xdg-mime default zen.desktop x-scheme-handler/https
    xdg-mime default zen.desktop text/html
  fi

  echo " Done!"
fi
