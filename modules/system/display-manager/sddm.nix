{
  config,
  pkgs,
  inputs,
  assets,
  ...
}:
let
  basePath = "/home/cartier/Documents/wallpapers";
  wallpaper = "Fantasy-Mountain.png";
in
{
  environment = {
    etc = {
      "sddm-wallpaper.png".source = "${assets}/sddm-background.png";
      "gtk-3.0/settings.ini".text = ''
        [Settings]
        gtk-icon-theme-name=Papirus
        gtk-theme-name=Adwaita
        gtk-cursor-theme-name=Adwaita
      '';
    };

    systemPackages = with pkgs; [
      papirus-icon-theme
      (sddm-chili-theme.override {
        themeConfig = {
          background = "/etc/sddm-wallpaper.png";
          ScreenWidth = "2560";
          ScreenHeight = "1440";
          recursiveBlurLoops = 1;
          recursiveBlurRadius = 10;
        };
      })
      libsForQt5.qt5.qtgraphicaleffects
    ];

    pathsToLink = [
      "/share/icons"
    ];

    variables = {
      GTK_ICON_THEME = "Papirus";
    };
  };

  programs.dconf.enable = true;

  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    theme = "chili";
    autoNumlock = true;
    package = pkgs.libsForQt5.sddm;
    extraPackages = with pkgs.libsForQt5.qt5; [
      qtgraphicaleffects
      qtquickcontrols2
      qtquickcontrols
      qtsvg
      qtdeclarative # QtQuick core
    ];
    settings = {
      X11 = {
        DisplayCommand = "/etc/sddm/Xsetup";
      };
    };
  };

  # Script for login screen to only show on primary monitor
  environment.etc."sddm/Xsetup" = {
    text = ''
      #!/bin/sh
      sleep 1
      # Log to see if script runs
      echo "SDDM Xsetup script running at $(date)" >> /tmp/sddm-setup.log

      # List available displays
      xrandr --query >> /tmp/sddm-setup.log 2>&1

      # Configure monitors
      echo "Setting DP-2 as primary" >> /tmp/sddm-setup.log
      xrandr --output DP-2 --primary --auto >> /tmp/sddm-setup.log 2>&1

      echo "Turning off DP-1" >> /tmp/sddm-setup.log  
      xrandr --output DP-1 --off >> /tmp/sddm-setup.log 2>&1

      echo "Xsetup script completed" >> /tmp/sddm-setup.log
    '';
    mode = "0755";
  };
}
