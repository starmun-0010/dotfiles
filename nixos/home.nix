{ config, pkgs, pkgs-un, ... }: {
  home.username = "muqsit";
  home.homeDirectory = "/home/muqsit";
  home.packages = with pkgs; [
    gh
    flameshot
    unzip
    cowsay
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
    obs-studio
    wezterm
    nushell
    qbittorrent
    vlc
    rofi
    vesktop
    picom
    zellij
    feh
    xss-lock
    nix-tree

    discord
    vscode
    steam
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

  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };
  home.stateVersion = "23.11";
}
