#!/bin/bash

#Refresh package cache
sudo apt update

#Upgrade packages
sudo apt upgrade -y

#Github
sudo apt install git -y
git config --global user.name muqsit
git config --global commit.gpgsign true

#Tmux
#sudo apt install tmux -y
#ln -sfn "$PWD/.tmux.conf" ~/.tmux.conf
#tmux source-file ~/.tmux.conf

#Kitty
sudo apt install kitty -y
mkdir -p ~/.config/kitty
ln -sfn "$PWD/kitty.conf" ~/.config/kitty/kitty.conf

#XClip
sudo apt install xclip -y

#Fish
sudo apt install fish -y
mkdir -p ~/.config/fish
ln -sfn "$PWD/config.fish" ~/.config/fish/config.fish

#Neofetch
sudo apt install neofetch -y
mkdir -p ~/.config/neofetch
ln -sfn "$PWD/config.conf" ~/.config/neofetch/config.conf

#Neo Vim
sudo apt install neovim -y
mkdir -p ~/.config/nvim
ln -sfn "$PWD/init.vim" ~/.config/nvim/init.vim
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
