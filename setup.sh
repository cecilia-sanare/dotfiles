#!/usr/bin/env sh

set -e

if [ $UID -eq 0 ]; then
    echo "This script should *NOT* be run as sudo!"
    exit 1
fi

command -v nix >/dev/null 2>&1 || { echo >&2 "Nix is not installed. Aborting."; exit 1; }

HOST=${1:-$(uname -n)}
OS=$(uname -o)

REPOS_DIR=$HOME/repos
REPO_DIR=$REPOS_DIR/nix-config
HOST_DIR=$REPO_DIR/hosts/$HOST

# Assume git isn't available because Apple is dumb and adds an alias for xcode...
nix-shell -p git

mkdir -p $REPOS_DIR > /dev/null

if [ ! -d "$REPO_DIR" ]; then
    echo "Pulling down repo..."
    git clone https://github.com/cecilia-sanare/nix-config $REPO_DIR > /dev/null
    # Update the origin to the SSH version now that we're all setup!
    git -C $REPO_DIR remote set-url origin git@github.com:cecilia-sanare/nix-config.git
else
    echo "Repo detected, skipping clone"
fi

cd $REPO_DIR

if [ -d "/etc/nixos" ]; then
    if [ ! -e "$HOST_DIR/hardware-configuration.nix" ]; then
        echo "Unable to locate hardware config, pulling from NixOS..."
        sudo cp /etc/nixos/hardware-configuration.nix $HOST_DIR/hardware-configuration.nix
    fi

    echo "/etc/nixos detected, removing to replace with symlink..."
    sudo rm -rf /etc/nixos > /dev/null
    echo "Creating symlink..."
    sudo ln -s $REPO_DIR /etc/nixos > /dev/null
fi

if [ $OS = "GNU/Linux" ]; then
    if [ -z "$(command -v nix)" ]; then
        sudo nixos-rebuild switch --flake .#${HOST}
    else
        # Pretty sure this is right, but honestly not sure
        sudo nix build .#nixosConfigurations.${HOST}.config.system.build.toplevel
    fi
elif [ $OS = "Darwin" ]; then
    if [ -z "$(command -v nix)" ]; then
        darwin-rebuild switch --flake .#${HOST}
    else
        nix run nix-darwin -- switch --flake .#${HOST}
    fi
else
    echo 2> "Unknown OS! ($OS)"
    exit 1
fi