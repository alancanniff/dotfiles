#!/usr/bin/env bash

cd ~ || exit

mybash=". ~/.config/bash/personal"
# only append the lines if they don't already exists
if ! grep -xq "${mybash}" ~/.bashrc; then
    echo "${mybash}" >>~/.bashrc
fi

# shellcheck source=/home/ac00/.bashrc
. "${HOME}/.bashrc"

# the bazel repo
sudo apt install -y apt-transport-https curl gnupg
curl -fsSL https://bazel.build/bazel-release.pub.gpg | gpg --dearmor > bazel.gpg
sudo mv bazel.gpg /etc/apt/trusted.gpg.d/
echo "deb [arch=amd64] https://storage.googleapis.com/bazel-apt stable jdk1.8" | sudo tee /etc/apt/sources.list.d/bazel.list

sudo apt update
sudo apt upgrade -y
sudo apt install -y \
    ranger \
    ripgrep \
    npm \
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
    xclip

curl -fsSL https://deb.nodesource.com/setup_current.x | sudo -E bash -
sudo apt install -y nodejs

sudo snap install clangd --classic
sudo snap install \
    shfmt

sudo npm install -g \
    neovim \
    bash-language-server

python3 -m pip install \
    pynvim \
    python-lsp-server[all]

sudo locale-gen en_US.UTF-8
sudo dpkg-reconfigure locales


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
popd  || exit

## fzf
if [[ ! -d fzf ]]; then
    git clone git@github.com:junegunn/fzf.git fzf
fi

pushd fzf || exit
git pull
./install --all --xdg
popd  || exit

##
popd || exit

#########################################################

tmux_cfg="$XDG_CONFIG_HOME/tmux/config"
if [[ ! -e ~/.tmux.conf ]]; then
    ln -s "${tmux_cfg}" .tmux.conf
fi

git_cfg="$XDG_CONFIG_HOME/git/config"
if [[ ! -e ~/.gitconfig ]]; then
    ln -s "${git_cfg}" .gitconfig
fi
