{ config, pkgs, pkgs-un, ... }: {

  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (_:true);
    };
  };

  home.packages = with pkgs; [ 
    

    xdg-utils
    vifm
    i3blocks
    fira-code-nerdfont
    pavucontrol
    gnumake
    gcc
    pkgs-un.protonvpn-cli_2
    pkgs-un.kanata
    pkgs-un.neovim
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
    pkgs-un.wezterm
    rofi
    picom
    zellij
    feh
    xss-lock
    nix-tree
    zoxide
    nushell

    vscode
  ];
  xdg.enable = true;
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

  home.file.wallpaper = {
    enable = true;
    source = config.lib.file.mkOutOfStoreSymlink ../wallpapers;
    target = "${config.home.homeDirectory}/.config/i3/wallpapers";
    force = true;
    recursive = true;
  };

  systemd.user.services.kanata = {
    Unit = {
      Description = "Launch Kanata";
    };
    Install = {
      WantedBy = [ "default.target" ];
    };
    Service = {
      ExecStart = "${pkgs.kanata}/bin/kanata";
    };
  };
  
  home.stateVersion = "23.11";
}
