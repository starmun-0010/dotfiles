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
	sudo nixos-rebuild switch --flake . && CURRENT=$(nixos-rebuild list-generations | grep current) && git commit -am "$CURRENT" && git push
fi 
