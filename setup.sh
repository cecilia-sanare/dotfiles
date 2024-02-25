#!/bin/sh

set -e

REPOS_DIR=$HOME/repos
DOTFILES_DIR=$REPOS_DIR/dotfiles

# Temporarily install git if it isn't already
which git > /dev/null 2>&1 || nix-shell -p git
mkdir -p $REPOS_DIR > /dev/null

if [ ! -d "$DOTFILES_DIR" ]; then
    echo "Pulling down dotfiles..."
    git clone https://github.com/cecilia-sanare/dotfiles $DOTFILES_DIR > /dev/null
else
    echo "Dotfiles detected, skipping clone"
(cd $DOTFILES_DIR && git remote set-url origin https://github.com/cecilia-sanare/dotfiles)
fi

if [ -d "/etc/nixos" ]; then
    echo "/etc/nixos detected, removing to replace with symlink..."
    sudo rm -rf /etc/nixos > /dev/null
fi

echo "Creating symlink..."
sudo ln -s $DOTFILES_DIR /etc/nixos > /dev/null
sudo nixos-rebuild switch

# Update the origin to the SSH version now that we're all setup!
(cd $DOTFILES_DIR && git remote set-url origin git@github.com:cecilia-sanare/dotfiles.git)