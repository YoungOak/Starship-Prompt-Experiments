#!/bin/zsh
[[ $ZSH_EVAL_CONTEXT =~ :file$ ]] && { echo "This script should not be sourced. Exiting."; exit 1; }

command -v gum &> /dev/null || { echo "gum could not be found, please install it first."; exit 1; }

eval "$(starship init zsh)"

clear
set -u -e

CONFIGS=$(git rev-parse --show-toplevel)/configs
while true; do
    # Select a Starship Configuration & set Env Var
    config=$(ls $CONFIGS | gum choose --ordered --header="Select a configuration file to watch...")
    [[ ! 0 -eq $? ]] && exit $?
    export STARSHIP_CONFIG=$CONFIGS/$config

    # Render prompt to stdout
    echo "Theme from '$config'"
    print -P "$(starship prompt) <-- input region between prompts --> $(starship prompt --right)"
    
    # Await confirmation to update starship config or not.
    gum confirm "Do you want to keep this prompt theme?" && { echo "Selected $config as Starships theme"; break; }
    [[ ! 1 -eq $? ]] && exit $?

    clear
done

DEFAULT_CONFIG="$HOME/.config/starship.toml"

# Create a backup of old config if it exists
[[ -f "$DEFAULT_CONFIG" ]] && cp $DEFAULT_CONFIG $DEFAULT_CONFIG.bkp

# Save config to starship default location
cp $CONFIGS/$config $DEFAULT_CONFIG