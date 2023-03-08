#!/usr/bin/env bash

# File containing my local mods...

export HISTSIZE=999999
export HISTFILESIZE=999999
shopt -s histappend

is_fedora() {

    var=$(cat /etc/*-release | grep ^NAME)
    fedora="NAME=\"Fedora Linux\""

    # Return values mimic command return value, not boolean
    if [[ $var =~ $fedora ]]; then
        return 0
    else
        return 1
    fi
}

# setxkbmap -option "caps:escape"

if ! is_fedora; then
    alias fd="fdfind"
fi

alias fd="fd -H --no-ignore"

alias lg="lazygit"
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

xdg_config="$(realpath ~)/.config"
export XDG_CONFIG_HOME="$xdg_config"

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
if command -v zoxide &>/dev/null; then
    eval "$(zoxide init bash)"
fi
