#!/bin/bash

#GPG keys
#Github CLI
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg \
&& sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg \
&& echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null 

#Refresh package cache
sudo apt update

#Upgrade packages
sudo apt upgrade -y

#Autoremove
sudo apt autoremove -y

#Github
sudo apt install git -y
git config --global user.name muqsit
git config --global commit.gpgsign true

#Tmux
#sudo apt install tmux -y
#ln -sfn "$PWD/.tmux.conf" ~/.tmux.conf
#tmux source-file ~/.tmux.conf
#Github CLI
sudo apt install gh -y

#Kitty
sudo apt install kitty -y
mkdir -p ~/.config/kitty
ln -sfn "$PWD/kitty.conf" ~/.config/kitty/kitty.conf
sudo update-alternatives --set x-terminal-emulator /usr/bin/kitty

#XClip
sudo apt install xclip -y

#Fish
sudo apt install fish -y
mkdir -p ~/.config/fish
ln -sfn "$PWD/config.fish" ~/.config/fish/config.fish
curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher
#Fisher
curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher
fisher install IlanCosman/tide@v5

#Neofetch
sudo apt install neofetch -y
mkdir -p ~/.config/neofetch
ln -sfn "$PWD/config.conf" ~/.config/neofetch/config.conf

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
ln -sfn "$PWD/nvim" ~/.config/
nvim -es -u init.vim -i NONE -c "PlugInstall" -c "qa"

#gogh theme
#id=$(gsettings get org.gnome.Terminal.ProfilesList default | tr -d "'")
#gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$id/ visible-name 'Default'
#sudo apt-get install dconf-cli uuid-runtime -y
#mkdir -p "temp"
#cd "temp"
#git clone https://github.com/Gogh-Co/Gogh.git gogh
#cd gogh/themes
#export TERMINAL=gnome-terminal
#./atom.sh
#./dracula.sh
#./wryan.sh
#cd ../../..
#rm -rf temp
#Locate
sudo apt install locate -y
sudo updatedb

#VS Code
sudo apt install code -y
