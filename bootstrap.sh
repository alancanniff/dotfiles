#!/usr/bin/env bash

# Boot strap scirpt for ubuntu 20.04

set -e

cd ~

mybash=". ~/.config/bash/personal"
# only append the lines if they don't already exists
if ! grep -xq "$mybash" ~/.bashrc; then
    echo "$mybash" >>~/.bashrc
fi

# shellcheck source=/home/ac00/.bashrc
. "$HOME"/.config/bash/personal

# the bazel repo
sudo apt install -y apt-transport-https curl gnupg
curl -fsSL https://bazel.build/bazel-release.pub.gpg | gpg --dearmor >bazel.gpg
sudo mv bazel.gpg /etc/apt/trusted.gpg.d/
echo "deb [arch=amd64] https://storage.googleapis.com/bazel-apt stable jdk1.8" | sudo tee /etc/apt/sources.list.d/bazel.list

sudo apt update
sudo apt upgrade -y
sudo apt install -y \
    ranger \
    ripgrep \
    minicom \
    mlocate \
    locales \
    python3-pip \
    bazel \
    shellcheck \
    snapd \
    cargo \
    libevent-dev \
    ncurses-dev \
    build-essential \
    bison \
    pkg-config \
    fd-find \
    universal-ctags \
    clang-format \
    xclip \
    bear

# curl -fsSL https://deb.nodesource.com/setup_current.x | sudo -E bash -
curl -fsSL https://deb.nodesource.com/setup_17.x | sudo -E bash -
sudo apt install -y -f nodejs

if [[ -z $WSLENV ]]; then

    sudo snap install clangd --classic
    sudo snap install \
        shfmt
fi

#########################################################
sudo npm install -g \
    neovim \
    bash-language-server \
    markdownlint-cli \
    cspell@latest

sudo npm install -g --save-dev --save-exact prettier

#########################################################
python3 -m pip install \
    pynvim \
    python-lsp-server[all]

#########################################################
if [[ -z $WSLENV ]]; then
    rustup install stable
    rustup default stable
fi

cargo install \
    stylua \
    shellharden

#########################################################

sudo locale-gen --purge en_US.UTF-8
echo -e 'LANG=en_NZ.UTF-8' tee -a /etc/default/locale >sudo

#########################################################

cd ~ || exit
if [[ ! -d projects ]]; then
    mkdir projects
fi

#########################################################
## build things from sourcw
pushd projects || exit

## neovim
if [[ ! -d neovim ]]; then
    git clone git@github.com:neovim/neovim.git
fi

pushd neovim || exit
sudo rm .deps/.ninja_log
git pull
make CMAKE_BUILD_TYPE=RelWithDebInfo
sudo make install
popd || exit

nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'

## tmux
if [[ ! -d tmux ]]; then
    git clone git@github.com:tmux/tmux.git
fi

pushd tmux || exit
git pull
sh autogen.sh
./configure && make
sudo make install
popd || exit

## fzf
if [[ ! -d fzf ]]; then
    git clone git@github.com:junegunn/fzf.git fzf
fi

pushd fzf || exit
git pull
./make install
fzf=$(realpath "./bin/fzf")
if [[ ! -e ~/.local/bin/fzf ]]; then
    echo ln -s "$fzf" "$(realpath ~/.local/bin/fzf)"
    ln -s "$fzf" "$(realpath ~/.local/bin/fzf)"
fi
./install --all --xdg
popd || exit

## lua-language-server
if [[ ! -d lua-language-server ]]; then
    git clone https://github.com/sumneko/lua-language-server
fi
pushd lua-language-server || exit
git submodule update --init --recursive
cd 3rd/luamake || exit
./compile/install.sh
cd ../.. || exit
./3rd/luamake/luamake rebuild

lua_lsp=$(realpath "./bin/lua-language-server")
if [[ ! -e ~/.local/bin/lua-language-server ]]; then
    echo ln -s "$lua_lsp" "$(realpath ~/.local/bin/lua-language-server)"
    ln -s "$lua_lsp" "$(realpath ~/.local/bin/lua-language-server)"
fi

popd || exit

##
popd || exit

#########################################################

tmux_cfg="$XDG_CONFIG_HOME/tmux/config"
if [[ ! -e ~/.tmux.conf ]]; then
    echo ln -s "$tmux_cfg" .tmux.conf
    ln -s "$tmux_cfg" .tmux.conf
else
    echo .tmux.conf exists
fi

git_cfg="$XDG_CONFIG_HOME/git/config"
if [[ ! -e ~/.gitconfig ]]; then
    echo ln -s "$git_cfg" .gitconfig
    ln -s "$git_cfg" .gitconfig
else
    echo .gitconfig exists
fi

#if [[ -n $ALWAYS_FALSE ]]; then
#    sudo apt-add-repository ppa:fish-shell/release-3
#    sudo apt update
#    sudo apt install fish
#fi

#########################################################
## fish stuff

#if 0; then
#    # this wrapper starts the fish shell from bash so that it inherits its enviroment
#    fishwrapper="$XDG_CONFIG_HOME/fish/fishlogin"
#    fishlogin="/usr/local/bin/fishlogin"

#    if [[ ! -e "$fishlogin" ]]; then
#        sudo cp "$fishwrapper" "$fishlogin"
#        sudo chmod 755 "$fishlogin"
#        echo "$fishlogin" | sudo tee -a /etc/shells
#        sudo usermod -s "$fishlogin" "$USER"
#    fi
#fi
