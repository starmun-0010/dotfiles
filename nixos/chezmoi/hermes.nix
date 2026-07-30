{ config, pkgs, ... }: {

  imports =
    [ 
      ./common.nix
    ];

  home.username = "hermes";
  home.homeDirectory = "/home/hermes";
  home.packages = with pkgs; [
        #    (with pkgs.dotnetCorePackages; combinePackages [
        # sdk_8_0
        # ])
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
    postman
    i3
  ];
  home.sessionVariables = {
    LOCALES_ARCHIVE = "${pkgs.glibcLocales}/lib/locale/locale-archive";
    LANG = "en_US.UTF-8";
  };

  # Auto-switch monitor layout on hotplug instead of re-running xrandr by
  # hand. Fingerprints are the raw EDID hex read from
  # /sys/class/drm/card*-<output>/edid on this machine; the actual
  # hotplug -> udev -> autorandr wiring lives in the system-level
  # services.autorandr.enable in nixos/configuration.nix.
  programs.autorandr = {
    enable = true;
    profiles = {
      docked = {
        fingerprint = {
          "eDP-1" = "00ffffffffffff0009e5310a000000000f1f0104a5221678073755965d58922920505400000001010101010101010101010101010101333f80dc70b03c403020360059d71000001a000000fd00283c4c4c10010a202020202020000000fe00424f452043510a202020202020000000fe004e5631363057554d2d4e34330a015902030000681a00000101283c00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000015fe";
          "HDMI-1" = "00ffffffffffff0030aeb363000000001221010380351e782ea3d5ab524f9d240f5054adcf00714f8180818a9500a9c0a9cfb300d1c0565e00a0a0a02950302035000f282100001a000000fc00503234682d33300a2020202020000000fd00324c1c701e000a202020202020000000ff00563930425a3241450a20202020014402032bf1480102030413901f1223090f0783010000e200ca67030c0010001844e305c000e60605015252498c0ad08a20e02d10103e96000f2821000018011d007251d01e206e2855000f282100001e023a801871382d40582c45000f282100001ecc7400a0a0a01e50302035000f282100001a0000000000000000000000005f";
        };
        config = {
          "eDP-1" = {
            enable = true;
            primary = true;
            position = "2560x0";
            mode = "1920x1200";
          };
          "HDMI-1" = {
            enable = true;
            position = "0x0";
            mode = "2560x1440";
          };
        };
      };
      mobile = {
        fingerprint = {
          "eDP-1" = "00ffffffffffff0009e5310a000000000f1f0104a5221678073755965d58922920505400000001010101010101010101010101010101333f80dc70b03c403020360059d71000001a000000fd00283c4c4c10010a202020202020000000fe00424f452043510a202020202020000000fe004e5631363057554d2d4e34330a015902030000681a00000101283c00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000015fe";
        };
        config = {
          "eDP-1" = {
            enable = true;
            primary = true;
            position = "0x0";
            mode = "1920x1200";
          };
        };
      };
    };
  };
  services.autorandr.enable = true;


  home.file.i3 = {
    enable = true;
    text = (builtins.readFile ../programs/i3/config) + ''
      set $monitor_left "HDMI-1"
      set $monitor_right "DP2"
      set $monitor_internal "eDP1"

 #assign workspace to monitor (reuses the $wsN names, icons included,
 #already set in the base i3 config above)
      workspace $ws1 output $monitor_left
      workspace $ws2 output $monitor_right
      workspace $ws3 output $monitor_internal
      workspace $ws4 output $monitor_left
      workspace $ws5 output $monitor_right
      workspace $ws6 output $monitor_internal
      workspace $ws7 output $monitor_left
      workspace $ws8 output $monitor_right
      workspace $ws9 output $monitor_internal
      workspace $ws10 output $monitor_internal
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

 home.file.dunstrc = {
   enable = true;
   source = config.lib.file.mkOutOfStoreSymlink ../programs/dunst/dunstrc;
   target = "${config.home.homeDirectory}/.config/dunst/dunstrc";
   force = true;
 };
}
