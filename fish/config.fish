if status is-interactive
    # Commands to run in interactive sessions can go here
end

set -gx EDITOR nvim
set -gx VISUAL nvim
set -gx HISTSIZE 999999
set -gx HISTFILESIZE 999999
set -gx XDG_CONFIG_HOME (realpath ~)/.config
set -gx XDG_CONFIG_HOME (realpath ~)/.config
fish_add_path ~/.cargo/bin
