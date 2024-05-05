{ config, pkgs, pkgs-un, ... }: {
 
  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (_:true);
    };
  };
  
  home.packages = with pkgs; [
    i3blocks
    fira-code-nerdfont
    pavucontrol
    gnumake
    gcc
    pkgs-un.protonvpn-cli_2
    pkgs-un.kanata
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

    discord
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

  home.file.nushellenv = {
    enable = true;
    source = config.lib.file.mkoutofstoresymlink ../programs/nushell/env.nu;
    target = "${config.home.homedirectory}/.config/nushell/env.nu";
    force = true;
  };

  home.file.nushellconfig = {
    enable = true;
    source = config.lib.file.mkoutofstoresymlink ../programs/nushell/config.nu;
    target = "${config.home.homedirectory}/.config/nushell/config.nu";
    force = true;
  };
  home.file.weztermsh = {
    enable = true;
    source = config.lib.file.mkoutofstoresymlink ../programs/wezterm/wezterm.sh;
    target = "${config.home.homedirectory}/.config/wezterm/wezterm.sh";
    force = true;
  };
 
  home.file.weztermlua = {
    enable = true;
    source = config.lib.file.mkoutofstoresymlink ../programs/wezterm/wezterm.lua;
    target = "${config.home.homedirectory}/.config/wezterm/wezterm.lua";
    force = true;
  };

  home.file.zellij = {
    enable = true;
    source = config.lib.file.mkOutOfStoreSymlink ../programs/zellij/config.kdl;
    target = "${config.home.homeDirectory}/.config/zellij/config.kdl";
    force = true;
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
