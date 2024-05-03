{ config, pkgs, pkgs-un, ... }: {

  imports =
    [ 
      ./common.nix
    ];

  home.username = "muqsit";
  home.homeDirectory = "/home/muqsit";
  home.packages = with pkgs; [
    dunst
    python3
    arandr
    glibcLocales
    nixgl.auto.nixGLDefault
    pkgs-un.postman
    slack
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
      bindsym $mod+t exec nixGL wezterm
    '';
    force = true;
    target = "${config.home.homeDirectory}/.config/i3/config";
  };
  home.file.bashprofile = {
   enable = true;
   source = config.lib.file.mkOutOfStoreSymlink ../programs/bash/.bash_profile;
   target = "${config.home.homeDirectory}/.bash_profile";
   force = true;
 };
 home.file.bourneprofile = {
   enable = true;
   source = config.lib.file.mkOutOfStoreSymlink ../programs/bash/.profile;
   target = "${config.home.homeDirectory}/.profile";
   force = true;
 };
}
