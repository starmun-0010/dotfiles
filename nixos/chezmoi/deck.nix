{ config, pkgs, ... }: {

  imports =
    [ 
      ./common.nix
    ];

  home.username = "deck";
  home.homeDirectory = "/home/deck";
  home.packages = with pkgs; [
    dunst
    python3
    arandr
    glibcLocales
    nixgl.auto.nixGLDefault
    postman
    slack
    i3
    (with pkgs.dotnetCorePackages; combinePackages [
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
      exec --no-startup-id "xrandr --output eDP --preferred --below DisplayPort-0 --preferred"
    '';
    force = true;
    target = "${config.home.homeDirectory}/.config/i3/config";
  };
}
