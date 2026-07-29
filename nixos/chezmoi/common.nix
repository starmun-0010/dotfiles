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
  # Apps (Zen, etc.) keep rewriting this as a real file when they register as
  # default handlers, which makes every switch try to back it up again and
  # fail once a stale .backup already exists. Always overwrite instead.
  xdg.configFile."mimeapps.list".force = true;
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
      ExecStart = "${pkgs.kanata}/bin/kanata";
    };
  };
  
  home.stateVersion = "23.11";
}
