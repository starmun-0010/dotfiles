#!/bin/bash

#GPG keys
#Github CLI
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg \
&& sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg \
&& echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null 

#PPA
#Fish
sudo add-apt-repository ppa:fish-shell/release-3 -y

#Emacs
sudo add-apt-repository ppa:kelleyk/emacs -y

#Make script excutable from any directory
SETUPROOT=$(realpath "$(dirname "${BASH_SOURCE[0]}")")
SETUPROOT+='/..'

#Refresh package cache
sudo apt update

#Upgrade packages
sudo apt upgrade -y

#Autoremove
sudo apt autoremove -y

#Github
sudo apt install git -y
git config --global commit.gpgsign true
git config --global core.editor "nvim"
git config --global core.pager "nvim -R"
git config --global pager.color no
git config --global diff.tool nvimdiff
git config --global merge.tool nvimdiff

#Github CLI
sudo apt install gh -y

#Kitty
sudo apt install kitty -y
mkdir -p ~/.config/kitty
ln -sfn "$SETUPROOT/kitty.conf" ~/.config/kitty/kitty.conf
sudo update-alternatives --set x-terminal-emulator /usr/bin/kitty

#XClip
sudo apt install xclip -y

#Fish
sudo apt install fish -y
mkdir -p ~/.config/fish
ln -sfn "$SETUPROOT/config.fish" ~/.config/fish/config.fish

# Oh my fish
curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install | fish

# Starship prompt
curl -sS https://starship.rs/install.sh | sh

#Neofetch
sudo apt install neofetch -y
mkdir -p ~/.config/neofetch
ln -sfn "$SETUPROOT/config.conf" ~/.config/neofetch/config.conf

#Node
LATEST_RELEASE=$(curl -L -s -H 'Accept: application/json' https://github.com/nvm-sh/nvm/releases/latest)
LATEST_VERSION=$(echo $LATEST_RELEASE | sed -e 's/.*"tag_name":"\([^"]*\)".*/\1/')
curl --create-dirs -OL --output-dir /tmp/nvm https://raw.githubusercontent.com/nvm-sh/nvm/$LATEST_VERSION/install.sh 
chmod +x /tmp/nvm/install.sh
/tmp/nvm/install.sh
rm -rf /tmp/nvm
source ~/.nvm/nvm.sh
nvm install --latest-npm
nvm use "$(nvm_ls)"
fish -c 'fish_add_path (string sub -e -4 (which node))'
fish -c 'fish_add_path (string sub -e -3 (which npm))'

#Neo Vim
LATEST_RELEASE=$(curl -L -s -H 'Accept: application/json' https://github.com/neovim/neovim/releases/latest)
LATEST_VERSION=$(echo $LATEST_RELEASE | sed -e 's/.*"tag_name":"\([^"]*\)".*/\1/')
ARTIFACT_URL="https://github.com/neovim/neovim/releases/download/$LATEST_VERSION/nvim-linux64.deb"
curl --create-dirs -OL --output-dir /tmp $(echo $ARTIFACT_URL) 
sudo apt install /tmp/nvim-linux64.deb -y
rm /tmp/nvim-linux64.deb
rm -rf ~/.config/nvim
ln -sfn "$SETUPROOT/nvim" ~/.config/
nvim -es -u init.vim -i NONE -c "PlugInstall" -c "qa"

#Emacs
sudo apt install emacs28 -y
#ln -sfn "$SETUPROOT/emacs" ~/.config/

#Locate
sudo apt install locate -y
sudo updatedb

#VS Code
sudo apt install code -y

#Themes
#Gedit
rm -rf /tmp/catappuccin
git clone https://github.com/catppuccin/gedit.git /tmp/catppuccin
cd /tmp/catppuccin
./install.sh
cd $(echo $SETUPROOT)
rm -rf /tmp/catppuccin
