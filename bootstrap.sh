echo "source ~/.config/bash/personal" >> ~/.bashrc

. ~/.bashrc

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
    fzf \
    python3-pip \
    bazel \
    shellcheck \
    snapd \
    cargo \
    libevent-dev \
    ncurses-dev \
    build-essential \
    bison \
    pkg-config

curl -fsSL https://deb.nodesource.com/setup_current.x | sudo -E bash -
sudo apt install -y nodejs

sudo snap install clangd --classic
sudo snap install shfmt

sudo npm i -g bash-language-server

python3 -m pip install \
    pynvim \
    python-lsp-server[all]

sudo locale-gen en_US.UTF-8
sudo dpkg-reconfigure locales


cd ~
mkdir projects
#########################################################
## neovim
pushd projects
git clone git@github.com:neovim/neovim.git
cd neovim
make CMAKE_BUILD_TYPE=RelWithDebInfo
sudo make install
popd

#########################################################
## tmux
cd ~
mkdir projects
pushd projects
git clone git@github.com:tmux/tmux.git
cd tmux
sh autogen.sh
./configure && make
sudo make install
popd

#########################################################

ln -s $XDG_CONFIG_HOME/tmux/config .tmux.conf
ln -s $XDG_CONFIG_HOME/git/config .gitconfig



