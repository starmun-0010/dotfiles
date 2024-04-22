{ config, pkgs, pkgs-un, ... }: {
  
  imports =
    [ 
      ./common.nix
    ];

  home.username = "deck";
  home.homeDirectory = "/home/deck";
  home.packages = with pkgs; [
  ];
}
