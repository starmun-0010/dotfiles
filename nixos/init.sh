#!/bin/bash

# Create xdg config folder
if ! [ -d "$HOME/.config" ]; then
	mkdir "$HOME/.config"
fi

#mask systemd network waiting service
if ! [ -L "/etc/systemd/system/systemd-networkd-wait-online.service" ] || ! [ -e "/etc/systemd/system/systemd-networkd-wait-online.service" ]; 
then
	echo "masking network waiting service"
	sudo systemctl mask systemd-networkd-wait-online.service
fi

#audio
if ! command -v pulseaudio &> /dev/null
then
	sudo apt -y install pulseaudio 
	sudo apt -y install pulseaudio-module-bluetooth
fi

if ! command -v alsa &> /dev/null
then
	sudo apt -y install alsa 
fi

#install bluetooth
if ! command -v bluetoothd &> /dev/null
then
	sudo apt -y install bluez
fi


#install xorg
if ! command -v startx &> /dev/null
then
	echo "startx not found, installing xorg"
	sudo apt -y install xorg
fi

#install nix
if ! command -v nix &> /dev/null
then
	echo "nix not found, installing nix"
	curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
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


#install home-manager
#if ! command -v home-manager &> /dev/null then
	#echo "home-manager not found, installing home-manager"
	#nix-channel --add 'https://github.com/nix-community/home-manager/archive/release-23.11.tar.gz' home-manager && nix-channel --update
	#nix-shell '<home-manager>' -A install
#fi

if [ -n "$2" ];
then 
	nix run nixpkgs#home-manager -- switch --flake . --impure
fi

#home manager iterations
if [ -n "$1" ];
then
	home-manager switch --flake . --impure
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
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh && . "$HOME/.cargo/env"
fi

if ! [ -f "/usr/local/bin/tuigreet/tuigreet" ]; then
	git clone https://github.com/apognu/tuigreet /tmp/tuigreet 
	pushd /tmp/tuigreet
	cargo build --release

	if ! [ -d "/usr/local/bin/tuigreet" ]; then
        	sudo mkdir /usr/local/bin/tuigreet
	fi
	sudo mv target/release/tuigreet /usr/local/bin/tuigreet
	popd
fi

#install greetd
if ! command -v greetd &> /dev/null 
then
	sudo apt -y install greetd
fi
if ! [ -d "/etc/greetd" ]; then
	sudo mkdir /etc/greetd
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

ln -sfn "$PWD/programs/kanata" "$HOME/.config/kanata"

#TOUCHPAD
xinput set-prop 'SYNA801A:00 06CB:CEC6 Touchpad' 'libinput Tapping Enabled' 1

xinput set-button-map 10 1 1 3 4 5 6 7
