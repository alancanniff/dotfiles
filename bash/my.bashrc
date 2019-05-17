# cygwin alias for gvim so it start with right home directory
alias gvim='HOME=/home/alan.canniff cygstart /cygdrive/c/Program\ Files/Vim/vim81/gvim.exe'
this_host=$(hostname)
export DISPLAY=$this_host:0.0

# enanle colors and a few detauls for common commands
alias grep='grep --color=auto'                     # show differences in colour
alias egrep='egrep --color=auto'              # show differences in colour
alias fgrep='fgrep --color=auto'              # show differences in colour

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

mycvs () {
    if [[ $# -ne 2  ]]; then
        echo "mycvs needs 2 argmumnets. operation and target"
        echo "mycvs add dirname"
        return 1
    fi

    if [ "$1" = "add" ]; then
        find "$2" -type d \! -name CVS -exec cvs add '{}' \;
        find "$2" \( -type d -name CVS -prune \) -o \( -type f -exec cvs add '{}' \; \)
        return 0
    fi
    echo "nothing done. $1 not recognised as a command"
}

alias rsync='rsync -P -rsh=ssh'

# find xcvr_644_625_fpll -type d \! -name CVS -exec cvs add '{}' \;
# find xcvr_644_625_fpll \( -type d -name CVS -prune \) -o \( -type f -exec cvs add '{}' \; \)
alias Xterm='XTerm.exe -fa Consolas -fs 11'
