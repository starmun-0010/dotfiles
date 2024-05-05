{ config, pkgs, pkgs-un, ... }: {

  imports =
    [ 
      ./common.nix
    ];

  home.username = "hermes";
  home.homeDirectory = "/home/hermes";
  home.packages = with pkgs; [
    acpilight
    dunst
    python3
    arandr
    glibcLocales
    nixgl.auto.nixGLDefault
    pkgs-un.postman
    i3
    (with pkgs-un.dotnetCorePackages; combinePackages [
      sdk_6_0
      sdk_7_0
      sdk_8_0
    ])
  ];
  home.sessionVariables = {
    LOCALES_ARCHIVE = "${pkgs.glibcLocales}/lib/locale/locale-archive";
    LANG = "en_US.UTF-8";
  };
  
  home.file.i3 = {
    enable = true;
    text = (builtins.readFile ../programs/i3/config) + ''
      exec --no-startup-id nixGL picom -b 
      exec --no-startup-id "xinput set-prop 'SYNA801A:00 06CB:CEC6 Touchpad' 'libinput Tapping Enabled' 1"
      exec --no-startup-id "xinput set-button-map 10 1 1 3 4 5 6 7"
      bindsym $mod+t exec nixGL wezterm
    '';
    force = true;
    target = "${config.home.homeDirectory}/.config/i3/config";
  };
 
 home.file.xinitrc = {
   enable = true;
   source = config.lib.file.mkOutOfStoreSymlink ../programs/xinit/.xinitrc;
   target = "${config.home.homeDirectory}/.xinitrc";
   force = true;
 };
}
