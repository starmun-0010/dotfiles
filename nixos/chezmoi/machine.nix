{ config, pkgs, pkgs-un, ... }: {
  
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
    obs-studio
    qbittorrent
    vlc
    vesktop
    
    steam
  ];
}
