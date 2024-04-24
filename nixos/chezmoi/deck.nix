{ config, pkgs, pkgs-un, ... }: {

  imports =
    [ 
      ./common.nix
    ];

  home.username = "deck";
  home.homeDirectory = "/home/deck";
  home.packages = with pkgs; [
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
}
