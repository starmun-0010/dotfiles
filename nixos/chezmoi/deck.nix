{ config, pkgs, pkgs-un, ... }: {

  imports =
    [ 
      ./common.nix
    ];

  home.username = "deck";
  home.homeDirectory = "/home/deck";
  home.packages = with pkgs; [
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
      bindsym $mod+d exec "rofi -modi drun,run -show drun"
      exec --no-startup-id xrandr --output eDP --auto --below DisplayPort-0 --auto
    '';
    force = true;
    target = "${config.home.homeDirectory}/.config/i3/config";
  };
}
