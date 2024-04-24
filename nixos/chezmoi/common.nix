{ config, pkgs, pkgs-un, ... }: {
 
  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (_:true);
    };
  };
  
  home.packages = with pkgs; [
    kanata
    protonvpn-gui
    gh
    flameshot
    unzip
    bat
    xplr
    projectable
    fzf
    bottom
    zenith
    xclip
    ripgrep
    firefox
    wezterm
    rofi
    picom
    zellij
    feh
    xss-lock
    nix-tree
    zoxide
    nushell

    discord
    vscode
  ];
  xdg.mimeApps = {
    enable = true;
  
    defaultApplications = {
      "text/html" = "firefox.desktop";
      "x-scheme-handler/http" = "firefox.desktop";
      "x-scheme-handler/https" = "firefox.desktop";
      "x-scheme-handler/about" = "firefox.desktop";
      "x-scheme-handler/unknown" = "firefox.desktop";
    };
  }; 
  programs.home-manager = {
    enable = true;
  };
  programs.git = {
   enable = true;
   userName = "starmun-0010";
   userEmail = "abdemuqsit@hotmail.com";

  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
  }; 

  home.file.i3 = {
    enable = true;
    source = config.lib.file.mkOutOfStoreSymlink ../programs/i3;
    target = "${config.home.homeDirectory}/.config/i3";
    force = true;
    recursive = true;
  };
  home.file.picom = {
    enable = true;
    source = config.lib.file.mkOutOfStoreSymlink ../programs/picom;
    target = "${config.home.homeDirectory}/.config/picom";
    force = true;
    recursive = true;
  };
  home.file.nushell = {
    enable = true;
    source = config.lib.file.mkOutOfStoreSymlink ../programs/nushell;
    target = "${config.home.homeDirectory}/.config/nushell";
    force = true;
    recursive = true;
  };

  home.file.wezterm = {
    enable = true;
    source = config.lib.file.mkOutOfStoreSymlink ../programs/wezterm;
    target = "${config.home.homeDirectory}/.config/wezterm";
    force = true;
    recursive = true;
  };
  home.file.zellij = {
    enable = true;
    source = config.lib.file.mkOutOfStoreSymlink ../programs/zellij;
    target = "${config.home.homeDirectory}/.config/zellij";
    force = true;
    recursive = true;
  };

  home.stateVersion = "23.11";
}
