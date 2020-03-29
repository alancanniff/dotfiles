# cygwin alias for gvim so it start with right home directory
alias gvim='HOME=/home/alan.canniff cygstart /cygdrive/c/Program\ Files/Vim/vim81/gvim.exe'
this_host=$(hostname)
export DISPLAY=$this_host:0.0

# enanle colors and a few detauls for common commands
alias ls='ls -hF --color=auto'                 # classify files in colour
alias ll='ls -l'                              # long list
alias la='ls -lA'                              # all but . and ..

# -i        ignore case
# -r        recursive
# -n        Prefix each line of output with the 1-based line number within its input file.
# -I        ignore files which grep thinks are binary
# -E        extended regular expression
mygrep () { grep -rnIiE --color "$1" "${2:-.}"; }
hg () { history | grep -iE --color "$1" ; }

cdw () { cd "$1" || return ; }

alias emacs='emacs -mm'

if [[ "$TERM" = "cygwin" ]]; then
    alias nvim='TERM=vtpcon nvim'
    alias vim='TERM=vtpcon vim'
fi

# find . -name CVS -type d -print | xargs /bin/rm -rf

mt () {
    # "make tail needs 1 argmumnets; the number of lines from make -n to run"
    if [[ $# = 1  ]]; then
        make -n | tail -"$1" | bash -
        return 1
    fi

    if [[ $# = 0  ]]; then
        make -n
        read -r -p "how many lines do you want to run: " answer
        make -n | tail -"$answer" | bash -
    fi

}

mycvs () {
    if [[ $# -ne 2  ]]; then
        echo "mycvs needs 2 argmumnets. operation and target"
        echo "mycvs add dirname"
        return 1
    fi

    if [ "$1" = "add" ]; then
        # add all the directories, but not cvs
        find "$2" -type d \! -name CVS -exec cvs add '{}' \;
        # then add all the files, but not cvs
        find "$2" \( -type d -name CVS -prune \) -o \( -type f -exec cvs add '{}' \; \)
        return 0
    fi

    if [ "$1" = "remove" ]; then
        # then remove all the files, but not cvs
        find "$2" \( -type d -name CVS -prune \) -o \( -type f -exec cvs remove '{}' \; \)
        return 0
    fi
    echo "nothing done. $1 not recognised as a command"
}

alias rsync='rsync -P -rsh=ssh'

# find xcvr_644_625_fpll -type d \! -name CVS -exec cvs add '{}' \;
# find xcvr_644_625_fpll \( -type d -name CVS -prune \) -o \( -type f -exec cvs add '{}' \; \)
alias Xterm='XTerm.exe +tb -fg linen -bg black -fa Consolas -fs 11'
alias vim=nvim
alias quart='quartus *.qpf'

# source $HOME/.config/bash/git-completion.bash
