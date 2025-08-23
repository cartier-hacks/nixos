{
  inputs,
  pkgs,
  assets,
  ...
}:

{
  home.file.".face.icon".source = "${assets}/user-icon.png";
  programs.hyprpanel = {
    enable = true;
    settings = {
      bar = {
        layouts = {
          # main monitor
          "1" = {
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

            ];
          };
          # second monitor
          "0" = {
            left = [
              "dashboard"
              "workspaces"
              "systray"
            ];
            middle = [
              "clock"
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
