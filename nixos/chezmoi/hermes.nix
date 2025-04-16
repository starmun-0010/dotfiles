{ config, pkgs, pkgs-un, ... }: {

  imports =
    [ 
      ./common.nix
    ];

  home.username = "hermes";
  home.homeDirectory = "/home/hermes";
  home.packages = with pkgs; [
    (with pkgs-un.dotnetCorePackages; combinePackages [
      sdk_8_0
    ])
    acpi
    lazygit
    testdisk
    ddrescue
    udiskie
    slack
    acpilight
    dunst
    arandr
    glibcLocales
    nixgl.auto.nixGLDefault
    pkgs-un.postman
    i3
  ];
  home.sessionVariables = {
    LOCALES_ARCHIVE = "${pkgs.glibcLocales}/lib/locale/locale-archive";
    LANG = "en_US.UTF-8";
  };
  
  home.file.i3 = {
    enable = true;
    text = (builtins.readFile ../programs/i3/config) + ''
      set $monitor_left "HDMI-1"
      set $monitor_right "DP2"
      set $monitor_internal "eDP1"
      set $ws1 "1"
      set $ws2 "2"
      set $ws3 "3"
      set $ws4 "4"
      set $ws5 "5"
      set $ws6 "6"
      set $ws7 "7"
      set $ws8 "8"
      set $ws9 "9"
      set $ws10 "10"
 
 #assign workspace to monitor
      workspace $ws1 output $monitor_left
      workspace $ws2 output $monitor_right
      workspace $ws3 output $monitor_internal
      workspace $ws4 output $monitor_left
      workspace $ws5 output $monitor_right
      workspace $ws6 output $monitor_internal
      workspace $ws7 output $monitor_left
      workspace $ws8 output $monitor_right
      workspace $ws9 output $monitor_internal
      workspace $ws10 output $monitor_left
      exec --no-startup-id "sleep 10; xrandr --output HDMI1  --preferred --left-of DP2 --output DP2  --preferred --left-of eDP1 --output eDP1 --preferred"
      exec --no-startup-id nixGL picom -b
      exec --no-startup-id "xinput set-prop 'SYNA801A:00 06CB:CEC6 Touchpad' 'libinput Tapping Enabled' 1"
      exec --no-startup-id "xinput set-button-map 10 1 1 3 4 5 6 7"
      bindsym $mod+t exec nixGL wezterm
    '';
    force = true;
    target = "${config.home.homeDirectory}/.config/i3/config";
  };
 
 home.file.xinitrc = {
   enable = true;
   source = config.lib.file.mkOutOfStoreSymlink ../programs/xinit/.xinitrc;
   target = "${config.home.homeDirectory}/.xinitrc";
   force = true;
 };
}
