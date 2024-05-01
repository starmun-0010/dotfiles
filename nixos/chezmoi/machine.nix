{ config, pkgs, pkgs-un, ... }: {
 nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (_:true);
    };
  }; 
  imports =
    [ 
      ./common.nix
    ];

  home.username = "muqsit";
  home.homeDirectory = "/home/muqsit";
  home.packages = with pkgs; [
    pkgs-un.popcorntime
    qbittorrent
    pavucontrol
    qbittorrent
    vlc
    vesktop
    
    steam
  ];
  
  home.file.i3 = {
    enable = true;
    text = (builtins.readFile ../programs/i3/config) + ''
      exec --no-startup-id picom -b 
      bindsym $mod+t exec wezterm
      bindsym $mod+d exec "rofi -modi drun,run -show drun"
    '';
    force = true;
    target = "${config.home.homeDirectory}/.config/i3/config";
  };
  
}
