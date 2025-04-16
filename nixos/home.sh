#!/bin/bash

if [ "$USER" == "hermes" ];
then
    source ./hermes.sh
elif [ "$USER" == "muqsit" ];
then
    source ./machine.sh
fi


if ! [ -L "$HOME/.config/kanata" ] || ! [ -e "$HOME/.config/kanata" ];
then
	ln -sfn "$PWD/programs/kanata" "$HOME/.config/"
fi

if ! [ -L "$HOME/.config/picom" ] || ! [ -e "$HOME/.config/picom" ];
then
	ln -sfn "$PWD/programs/picom" "$HOME/.config/"
fi

if ! [ -L "$HOME/.config/wezterm" ] || ! [ -e "$HOME/.config" ];
then
	ln -sfn "$PWD/programs/wezterm" "$HOME/.config/"
fi

if ! [ -L "$HOME/.config/nvim" ] || ! [ -e "$HOME/.config" ];
then
	ln -sfn "$PWD/programs/nvim" "$HOME/.config/"
fi

if ! [ -L "$HOME/.config/zellij" ] || ! [ -e "$HOME/.config/zellij" ];
then
	ln -sfn "$PWD/programs/zellij" "$HOME/.config/"
fi


if ! [ -L "$HOME/.config/nushell" ] || ! [ -e "$HOME/.config/nushell" ];
then
	ln -sfn "$PWD/programs/nushell" "$HOME/.config/"
fi

if ! [ -L "$HOME/.config/stylua" ] || ! [ -e "$HOME/.config/stylua" ];
then
	ln -sfn "$PWD/programs/stylua" "$HOME/.config/"
fi

if ! [ -L "$HOME/.config/i3blocks" ] || ! [ -e "$HOME/.config/i3blocks" ];
then
	ln -sfn "$PWD/programs/i3blocks" "$HOME/.config/"
fi

if ! [ -L "$HOME/.omnisharp" ] || ! [ -e "$HOME/.omnisharp" ];
then
	ln -sfn "$PWD/programs/.omnisharp" "$HOME/"
fi

#github
TOKEN=$(gh auth token 2>&1 >/dev/null)
if [ "$TOKEN" == "no oauth token" ];
then
	rm ~/.config/git/config
	gh auth login
	home-manager switch --flake . --impure
	git push -u origin 2024
fi

if [ "$1" == "gen" ];
then
	printf "\nHome Manager Changes\n\n"
	git diff -U0
	read -p "Continue? " answer
	if [ "$answer" != "${answer#[Nn]}" ]; 
	then
		exit 0
	fi
	git add --all
	home-manager switch --flake . --impure
	git commit -am "$(home-manager generations | head -n 1)"
	git push
fi 

