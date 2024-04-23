{ config, pkgs, pkgs-un, ... }: {
 
  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (_:true);
    };
  };
  
  home.packages = with pkgs; [
    protonvpn-gui
    gh
    flameshot
    unzip
    bat
    xplr
    projectable
    fzf
    zoxide
    bottom
    zenith
    xclip
    ripgrep
    firefox
    wezterm
    nushell
    rofi
    picom
    zellij
    feh
    xss-lock
    nix-tree

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
    source = config.lib.file.mkOutOfStoreSymlink ../programs/i3/xx;
    target = "${config.home.homeDirectory}/.config/i3/config";
    force = true;
  };

  home.stateVersion = "23.11";
}
