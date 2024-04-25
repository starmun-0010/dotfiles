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

  home.file.wallpaper = {
    enable = true;
    source = config.lib.file.mkOutOfStoreSymlink ../wallpapers;
    target = "${config.home.homeDirectory}/.config/i3/wallpapers";
    force = true;
    recursive = true;
  };

  home.file.picom = {
    enable = true;
    source = config.lib.file.mkOutOfStoreSymlink ../programs/picom/picom.conf;
    target = "${config.home.homeDirectory}/.config/picom/picom.conf";
    force = true;
  };
  home.file.nushellenv = {
    enable = true;
    source = config.lib.file.mkOutOfStoreSymlink ../programs/nushell/env.nu;
    target = "${config.home.homeDirectory}/.config/nushell/env.nu";
    force = true;
  };
  home.file.nushellconfig = {
    enable = true;
    source = config.lib.file.mkOutOfStoreSymlink ../programs/nushell/config.nu;
    target = "${config.home.homeDirectory}/.config/nushell/config.nu";
    force = true;
  };
  home.file.weztermsh = {
    enable = true;
    source = config.lib.file.mkOutOfStoreSymlink ../programs/wezterm/wezterm.sh;
    target = "${config.home.homeDirectory}/.config/wezterm/wezterm.sh";
    force = true;
  };
 
  home.file.weztermlua = {
    enable = true;
    source = config.lib.file.mkOutOfStoreSymlink ../programs/wezterm/wezterm.lua;
    target = "${config.home.homeDirectory}/.config/wezterm/wezterm.lua";
    force = true;
  };
  home.file.zellij = {
    enable = true;
    source = config.lib.file.mkOutOfStoreSymlink ../programs/zellij/config.kdl;
    target = "${config.home.homeDirectory}/.config/zellij/config.kdl";
    force = true;
  };

  home.stateVersion = "23.11";
}
