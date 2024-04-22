{ config, pkgs, pkgs-un, ... }: {

  imports =
    [ 
      ./common.nix
    ];

  home.username = "deck";
  home.homeDirectory = "/home/deck";
  home.packages = with pkgs; [
    pkgs-un.postman
    slack
     (with pkgs-un.dotnetCorePackages; combinePackages [
      sdk_6_0
      sdk_7_0
      sdk_8_0
    ])
  ];

  xsession.windowManager.i3 = {
    enable = true;
  };
}
