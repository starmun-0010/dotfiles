{ config, pkgs, pkgs-un, ... }: {
 nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (_:true);
    };
  }; 
  imports =
    [ 
      ./common.nix
    ];

  home.username = "muqsit";
  home.homeDirectory = "/home/muqsit";
  home.packages = with pkgs; [
   (with pkgs-un.dotnetCorePackages; combinePackages [
      sdk_6_0
      sdk_7_0
      sdk_8_0
      sdk_9_0
    ])
   pkgs-un.popcorntime
    qbittorrent
    qbittorrent
    vlc
    vesktop
    
    steam
  ];
  
  home.file.i3 = {
    enable = true;
    text = (builtins.readFile ../programs/i3/config) + ''
      exec --no-startup-id picom -b 
      bindsym $mod+t exec wezterm
    '';
    force = true;
    target = "${config.home.homeDirectory}/.config/i3/config";
  };
  
}
