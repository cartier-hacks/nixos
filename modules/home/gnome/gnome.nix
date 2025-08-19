{
  config,
  pkgs,
  lib,
  ...
}:
{
  imports = [
    ./gnome/keybinds.nix
  ];

  window

  home.packages = with pkgs; [
    gnomeExtensions.blur-my-shell
    gnomeExtensions.dash-to-dock
    gnomeExtensions.space-bar
    gnomeExtensions.just-perfection
  ];

  dconf.enable = true;

  # All the gnome configuration is under this
  dconf.settings = {
    # Interface settings
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      gtk-theme = "Adwaita-dark";
      icon-theme = "Adwaita";
      cursor-theme = "Adwaita";
      font-name = "Cantarell 11";
      document-font-name = "Cantarell 11";
      monospace-font-name = "FiraCode Nerd Font 10";
      show-battery-percentage = true;
      clock-show-weekday = true;
      clock-show-date = true;
      clock-show-seconds = false;
      clock-format = "12h";
    };

    # Nautilus (file manager) preferences
    "org/gnome/nautilus/preferences" = {
      default-folder-viewer = "list-view";
      search-filter-time-type = "last_modified";
      show-hidden-files = true;
    };

    # GNOME Shell extensions
    "org/gnome/shell" = {
      enabled-extensions = [
        "blur-my-shell@aunetx"
        "space-bar@luchrioh"
        "just-perfection-desktop@just-perfection"
      ];
      disabled-extensions = [
        "tiling-assistant@ubuntu.com"
        "ubuntu-appindicators@ubuntu.com"
        "ubuntu-dock@ubuntu.com"
        "ding@rastersoft.com"
      ];
    };

    # Dash to Dock settings
    "org/gnome/shell/extensions/dash-to-dock" = {
      dock-position = "BOTTOM";
      dock-fixed = false;
      intellihide-mode = "FOCUS_APPLICATION_WINDOWS";
      show-favorites = true;
      show-running = true;
      show-apps-at-top = true;
      click-action = "cycle-windows";
    };

    # Power settings
    "org/gnome/settings-daemon/plugins/power" = {
      sleep-inactive-ac-type = "nothing";
      sleep-inactive-battery-timeout = 1800;
    };

    # Privacy settings
    "org/gnome/desktop/privacy" = {
      report-technical-problems = false;
      send-software-usage-stats = false;
    };
  };
}
