{ inputs, pkgs, ... }:

{
  programs.hyprpanel = {
    enable = true;
    settings = {
      bar = {
        layouts = {
          "0" = {
            left = [
              "dashboard"
              "workspaces"
              "cpu"
              "ram"
              "systray"
            ];
            middle = [
              "clock"
            ];
            right = [
              "media"
              "volume"
              "network"
              "notifications"
              "battery"
            ];
          };
        };
      };

      bar.launcher.autoDetectIcon = true;
      bar.workspaces.show_icons = true;

      menus.clock = {
        time = {
          military = false;
          hideSeconds = true;
        };
        weather.unit = "imperial";
      };

      menus.dashboard.directories.enabled = false;
      menus.dashboard.stats.enable_gpu = true;

      theme = import ./hyprpanel/theme-gruvbox.nix;

      # theme.bar.transparent = {
      #   transparent = false;
      #   buttons.style = "wave";
      # };

      # theme.font = {
      #   name = "CaskaydiaCove NF";
      #   size = "14px";
      # };
    };
  };
}
