#Refresh package cache
sudo apt update

#Upgrade packages
sudo apt upgrade -y

#Github
sudo apt install git -y
git config --global user.email abdemuqsit@hotmail.com
git config --global user.name muqsit
git config --global commit.gpgsign true

#Tmux
sudo apt install tmux -y
ln -s "$PWD/.tmux.conf" ~/.tmux.conf
tmux source-file ~/.tmux.conf

#XClip
sudo apt install xclip -y

#Fish
sudo apt install fish -y
ln -s "$PWD/config.fish" ~/.config/fish/config.fish

#Neo Vim
sudo apt install neovim -y
ln -s "$PWD/init.vim" ~/.config/nvim/init.vim

#VS Code
sudo apt install code -y
