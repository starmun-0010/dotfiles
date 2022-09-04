#Github
sudo apt install git -y
git config --global user.email abdemuqsit@hotmail.com
git config --global user.name muqsit
git config --global commit.gpgsign true

#Tmux
sudo apt install tmux -y
ln -s "$PWD/.tmux.conf" ~/.tmux.conf
tmux source-file ~/.tmux.conf

#Fish
sudo apt install fish -y

#XClip
sudo apt install xclip -y

#VS Code
sudo apt install code -y
