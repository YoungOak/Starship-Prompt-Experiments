#!/bin/zsh
[[ $ZSH_EVAL_CONTEXT =~ :file$ ]] && { echo "This script should not be sourced. Exiting."; exit 1; }

ROOT_DIR=$(git rev-parse --show-toplevel)

vhs ${ROOT_DIR}/tapes/selector_showcase_zsh.tape -o ${ROOT_DIR}/media/selector_showcase_zsh.gif
vhs ${ROOT_DIR}/tapes/selector_showcase_zsh.tape -o ${ROOT_DIR}/media/selector_showcase_zsh.mp4