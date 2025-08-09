alias so="smart-open"

export VINTAGE_STORY="$HOME/.local/share/vintagestory"

if status is-interactive
    # Commands to run in interactive sessions can go here
    fastfetch | dotacat --seed 200 -p 10
end

