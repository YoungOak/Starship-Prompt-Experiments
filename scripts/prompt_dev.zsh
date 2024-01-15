#!/bin/zsh
[[ $ZSH_EVAL_CONTEXT =~ :file$ ]] && { echo "This script should not be sourced. Exiting."; exit 1; }

command -v watchexec &> /dev/null || { echo "watchexec could not be found, please install it first."; exit 1; }

eval "$(starship init zsh)"

# Select the configuration file to work on
config=$(ls configs | gum choose --header="Select a configuration file to watch...")

# Set Custom Config Env Var so starship renders the correct prompt
export STARSHIP_CONFIG=$(git rev-parse --show-toplevel)/configs/$config

# Start a WatchExec process that will render the prompt each time the selected config is altered.
watchexec --clear=reset --watch configs/$config --shell=$SHELL -- \
    'print -P "$(starship prompt) <-- input region between prompts --> $(starship prompt --right)"'