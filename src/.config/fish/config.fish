set -g fish_greeting ""

set -l OS $(uname -s)

if test -e ~/.cargo/bin
  set -gx PATH ~/.cargo/bin $PATH
end

if test -e ~/.local/share/vintagestory
  set VINTAGE_STORY "$HOME/.local/share/vintagestory"
end

if test -e ~/.nvm
  export NVM_DIR="$HOME/.nvm"

  function nvm
    bass source $NVM_DIR/nvm.sh --no-use ';' nvm $argv
  end
end

# ####################### #
# OS Specific Shenanigans #
# ####################### #

if test $OS = "Darwin"
  # Suppress "Last login" message on macOS by creating ~/.hushlogin
  if not test -e ~/.hushlogin
    touch ~/.hushlogin
  end

  if test -e /opt/homebrew/bin/brew
    eval "$(/opt/homebrew/bin/brew shellenv)"
  end
end

###########
# Aliases #
###########

if type -q cursor; alias code="cursor"; end
if type -q smart-open; alias so="smart-open"; end

if status is-interactive
  # Commands to run in interactive sessions can go here
  starship init fish | source
  fastfetch | dotacat --seed 200 -p 10
end
