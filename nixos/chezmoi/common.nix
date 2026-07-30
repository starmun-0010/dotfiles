{ config, pkgs, ... }: {

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
    starship
    nerd-fonts.fira-code
    pavucontrol
    gnumake
    gcc
    proton-vpn-cli
    kanata
    neovim
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
    batsignal

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
   settings.user.name = "starmun-0010";
   settings.user.email = "abdemuqsit@hotmail.com";
  };

  gtk = {
    enable = true;
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
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
      # --port exposes LayerChange events over TCP for kanata-nav-indicator
      ExecStart = "${pkgs.kanata}/bin/kanata --port 5829";
      Restart = "on-failure";
    };
  };

  systemd.user.services.kanata-nav-indicator = {
    Unit = {
      Description = "Show i3 bar while kanata's hjkl nav layer is active";
      After = [ "kanata.service" ];
    };
    Install = {
      WantedBy = [ "default.target" ];
    };
    Service = {
      ExecStart = "${config.home.homeDirectory}/.config/kanata/scripts/nav-indicator";
      Restart = "on-failure";
    };
  };

  systemd.user.services.batsignal = {
    Unit = {
      Description = "Low battery notification daemon";
    };
    Install = {
      WantedBy = [ "default.target" ];
    };
    Service = {
      ExecStart = ''${pkgs.batsignal}/bin/batsignal -i -w 20 -c 10 -d 5 -D "systemctl suspend"'';
      Restart = "on-failure";
    };
  };

  home.stateVersion = "23.11";
}
