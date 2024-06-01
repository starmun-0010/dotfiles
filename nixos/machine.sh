if [ "$1" == "gen" ];
then
	printf "\nNix Chanes\n\n"
	git diff -U0
	read -p "Continue? " answer
	if [ "$answer" != "${answer#[Nn]}" ]; 
	then
		exit 0
	fi
	git add --all
	sudo nixos-rebuild switch --flake .
	git commit -am "$(home-manager generations | head -n 1)"
	git push
fi 
