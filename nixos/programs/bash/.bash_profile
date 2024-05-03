
if [ -f  "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh" ];
then
	. "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"
fi


if [ -z "$DISPLAY" ] && [ "$XDG_VTNR" = 1 ]; then
  exec startx
fi
