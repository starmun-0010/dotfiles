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
    obs-studio
    qbittorrent
    vlc
    vesktop
    
    steam
  ];
}
