#!/bin/bash

if ! command -v curl &> /dev/null
then
	sudo apt install curl
fi
#install nix
if ! command -v nix &> /dev/null
then
	echo "nix not found, installing nix"
	curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install --no-confirm
	if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
  		. '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
	fi

	nix-channel --add https://nixos.org/channels/nixos-23.11 nixpkgs
	nix-channel --update
fi

if ! [ -f "$HOME/.config/nix/nix.conf" ]; then
	if ! [ -d "$HOME/.config/nix" ]; then
		mkdir ~/.config/nix
	fi	
	cp ./programs/nix/nix.conf ~/.config/nix/nix.conf
fi
if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
	. '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
fi

# End Nix


if [ "$1" == "init" ];
then 
	nix run nixpkgs#home-manager -- switch --flake . --impure
fi

#home manager iterations
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

#kanata
if ! [ -f "/etc/udev/rules.d/kanata.rules" ]; 
then
	getent group uinput || sudo groupadd uinput
	getent group input  || sudo groupadd input

	sudo usermod -aG input $USER
	sudo usermod -aG uinput $USER

	echo 'KERNEL=="uinput", MODE="0660", GROUP="uinput", OPTIONS+="static_node=uinput"' | sudo tee /etc/udev/rules.d/kanata.rules
        sudo modprobe uinput
fi

if ! command -v cargo &> /dev/null 
then
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y 
       	. "$HOME/.cargo/env"
fi

#install greetd
if ! command -v greetd &> /dev/null 
then
	sudo apt -y install greetd
fi
if ! [ -d "/etc/greetd" ]; then
	sudo mkdir /etc/greetd
fi

if ! [ -f "/usr/local/bin/tuigreet/tuigreet" ]; then
	git clone https://github.com/apognu/tuigreet /tmp/tuigreet 
	pushd /tmp/tuigreet
	cargo build --release

	if ! [ -d "/usr/local/bin/tuigreet" ]; then
        	sudo mkdir /usr/local/bin/tuigreet
		sudo mkdir /var/cache/tuigreet
		sudo chmod 777 /var/cache/tuigreet
	fi
	sudo mv target/release/tuigreet /usr/local/bin/tuigreet
	popd
fi

#backlight
if ! [ -f "/etc/udev/rules.d/backlight.rules" ]; 
then
	echo 'ACTION=="add", SUBSYSTEM=="backlight", KERNEL=="intel_backlight", RUN+="/usr/bin/chgrp video /sys/class/backlight/intel_backlight/brightness"
ACTION=="add", SUBSYSTEM=="backlight", KERNEL=="intel_backlight", RUN+="/usr/bin/chmod 777 /sys/class/backlight/intel_backlight/brightness"
' | sudo tee /etc/udev/rules.d/backlight.rules
fi

if ! [ -L "/etc/X11/xorg.conf.d/20-intel.conf" ] || ! [ -e "/etc/X11/xorg.conf.d/20-intel.conf" ]; 
then
	sudo ln -sfn "$PWD/programs/X11/xorg.conf" "/etc/X11/xorg.conf.d/20-intel.conf"
fi

if ! [ -L "/etc/greetd/config.toml" ] || ! [ -e "/etc/greetd/config.toml" ]; 
then
        sudo ln -sf "$PWD/programs/greetd/config.toml" "/etc/greetd/config.toml"	
fi

if ! [ -L "~/.profile" ] || ! [ -e "~/.profile" ]; 
then
	ln -sf "$PWD/programs/bash/.profile" "$HOME/.profile"
fi

if ! [ -L "~/.bash_profile" ] || ! [ -e "~/.bash_profile" ]; 
then
	ln -sf "$PWD/programs/bash/.bash_profile" "$HOME/.bash_profile"
fi

if ! [ -L "$HOME/.config/kanata" ] || ! [ -e "$HOME/.config/kanata" ]; 
then
	ln -sfn "$PWD/programs/kanata" "$HOME/.config/kanata"
fi
if ! [ -L "$HOME/.config/picom/picom.conf" ] || ! [ -e "$HOME/.config/picom/picom.conf" ]; 
then
	ln -sf "$PWD/programs/picom/picom.conf" "$HOME/.config/picom/picom.conf"
fi

if ! [ -L "$HOME/.config/wezterm/wezterm.sh" ] || ! [ -e "$HOME/.config/wezterm/wezterm.sh" ]; 
then
	mkdir "$HOME/.config/wezterm"
	ln -sf "$PWD/programs/wezterm/wezterm.sh" "$HOME/.config/wezterm/wezterm.sh"
fi

if ! [ -L "$HOME/.config/wezterm/wezterm.lua" ] || ! [ -e "$HOME/.config/wezterm/wezterm.lua" ]; 
then
	mkdir "$HOME/.config/wezterm"
	ln -sf "$PWD/programs/wezterm/wezterm.lua" "$HOME/.config/wezterm/wezterm.lua"
fi

if ! [ -L "$HOME/.config/nvim/init.lua" ] || ! [ -e "$HOME/.config/nvim/init.lua" ]; 
then
	mkdir "$HOME/.config/nvim"
	ln -sf "$PWD/programs/nvim/init.lua" "$HOME/.config/nvim/init.lua"
fi

#github
TOKEN=$(gh auth token 2>&1 >/dev/null)
if [ "$TOKEN" == "no oauth token" ];
then
	rm ~/.config/git/config
	gh auth login
        git push -u origin 2024			
	home-manager switch --flake . --impure
fi
