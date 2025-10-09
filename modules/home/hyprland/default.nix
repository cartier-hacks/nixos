{
  config,
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    ./binds.nix
    ./hyprpaper.nix
    ./hyprpanel.nix
    #./wofi.nix
    ./desktop-env.nix
    ./screenshots.nix
    #./hyprpanel2.nix
    ../common/waycast.nix
  ];

  home = {
    sessionVariables = {
      NIXOS_OZON_WL = "1";
    };

    packages = with pkgs; [
      # Notifications
      libnotify

      # Screenshots

      wl-clipboard

      # Desktop env
      hyprpanel

      # Utility
      wl-clipboard
    ];
  };

  # Important for certain apps working
  # and dark mode being respected
  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-hyprland
    ];
  };

  gtk = {
    enable = true;
    iconTheme = {
      name = "Papirus";
      package = pkgs.papirus-icon-theme;
    };
  };

  wayland.windowManager.hyprland = {

    enable = true;

    settings = {

      layerrule = [
        "noanim, Waycast"
      ];

      # MacOS Cursors
      env = [
        "XCURSOR_THEME,macOS"
        "XCURSOR_SIZE,24"
      ];

      input = {
        repeat_delay = 200;
        repeat_rate = 20;
        touchpad.natural_scroll = true;
      };

      monitor = [
        "eDP-1, 2560x1440@60, 0x0, 1"
      ];

      general = {
        layout = "master";
        gaps_out = 0;
        gaps_in = 0;
      };

      workspace = [
        "1, persistent:true, monitor:DP-2"
        "2, persistent:true, monitor:DP-2"
        "3, persistent:true, monitor:DP-2"
        "4, persistent:true, monitor:DP-2"
        "5, persistent:true, monitor:DP-2"
        "6, persistent:true, monitor:DP-2"
      ];

      # Window rules

      windowrulev2 = [
        "opacity 0.85, class:^(Code)$"
        "move 0 0,class:(flameshot),title:(flameshot)"
        "pin,class:(flameshot),title:(flameshot)"
        "fullscreenstate,class:(flameshot),title:(flameshot)"
        "float,class:(flameshot),title:(flameshot)"
        "monitor DP-2, class:^(flameshot)$"
      ];

      decoration = {
        blur = {
          enabled = false;
          size = 8;
          passes = 2;
        };

        active_opacity = 1.0;
        inactive_opacity = 1.0;
      };

      exec-once = [
        # "quickshell -c hyprshell"
        "hyprpanel"
        # macOS cursor
        "hyprctl setcursor macOS 24"
      ];
    };

    plugins = [
      # inputs.hyprland-plugins.packages.${pkgs.stdenv.hostPlatform.system}.hyprbars
    ];
  };
}
