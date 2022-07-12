#!/usr/bin/env bash

# File containing my local mods...

export HISTSIZE=999999
export HISTFILESIZE=999999
shopt -s histappend

# setxkbmap -option "caps:escape"

alias fd="fdfind"
alias rm="rm -f"
alias nvim="\$HOME/.local/bin/nvim"
alias vim="nvim"
alias minicom="minicom -c on"
alias untar="tar -zxvf"
export EDITOR="nvim"
export VISUAL="nvim"

export LESS="-FRX"
export RANGER_LOAD_DEFAULT_RC=FALSE
# export PATH="$PATH:/app/location/node_modules/.bin"
export PATH="/home/$USER/.local/bin:$PATH"
export PATH="/home/$USER/.cargo/bin:$PATH"

export XDG_CONFIG_HOME="$(realpath ~)/.config"

# -i        ignore case
# -r        recursive
# -n        Prefix each line of output with the 1-based line number within its input file.
# -I        ignore files which grep thinks are binary
# -E        extended regular expression
mygrep() { grep -rnIiE --color "$1" "${2:-.}"; }
fzfco() { git checkout "$(git branch -l | fzf)"; }

work="$XDG_CONFIG_HOME/bash/work.bash"
if [[ -f $work ]]; then
    # shellcheck source=/home/alan/.config/bash/work.bash
    . "$work"
fi
