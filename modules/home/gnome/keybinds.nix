{
  config,
  pkgs,
  lib,
  ...
}:
let
  # Helper function to create custom keybindings
  mkCustomKeybinding =
    index:
    {
      name,
      command,
      binding,
    }:
    {
      "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom${toString index}" = {
        inherit name command binding;
      };
    };

  # Helper function to generate custom keybinding paths
  mkCustomKeybindingPaths =
    count:
    lib.genList (
      i: "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom${toString i}/"
    ) count;

  # Helper function to generate workspace keybindings
  mkWorkspaceKeybindings =
    count:
    lib.genAttrs (lib.genList (i: "switch-to-workspace-${toString (i + 1)}") count) (
      name:
      let
        num = lib.strings.removePrefix "switch-to-workspace-" name;
      in
      [ "<Super>${num}" ]
    );

  # Helper function to disable application shortcuts
  mkDisableAppShortcuts =
    count:
    lib.genAttrs (lib.genList (i: "switch-to-application-${toString (i + 1)}") count) (name: [ ]);

  # Define custom keybindings
  customKeybindings = [
    {
      name = "Flameshot";
      command = "flameshot gui";
      binding = "<Super><Shift>s";
    }
    {
      name = "New Brave window";
      command = "brave";
      binding = "<Super><Shift>o";
    }
    {
      name = "New Brave incognito window";
      command = "brave --incognito";
      binding = "<Super><Shift>p";
    }
    {
      name = "Kitty";
      command = "kitty";
      binding = "<Super>q";
    }
    {
      name = "File Explorer";
      command = "nautilus --new-window";
      binding = "<Super>e";
    }
    {
      name = "Project selector";
      command = "kitty --start-as=normal -- bash -ic 'proj'";
      binding = "<Control><Shift>p";
    }
    {
      name = "Open nix config";
      command = "kitty --start-as=normal -- bash -ic 'code ~/nix && exit'";
      binding = "<Super><Shift>n";
    }
    {
      name = "ChatGPT";
      command = "brave --new-window --app=https://chatgpt.com";
      binding = "<Super>Return";
    }
    {
      name = "BTop";
      command = "kitty --start-as=normal -- bash -ic 'btop'";
      binding = "<Control><Shift>Escape";
    }
    {
      name = "FastFetch";
      command = "kitty --start-as=normal -- bash -ic 'fastfetch'";
      binding = "<Control><Alt>1";
    }
  ];

  # Generate all custom keybinding settings
  customKeybindingSettings = lib.foldl lib.mergeAttrs { } (
    lib.imap0 (index: keybind: mkCustomKeybinding index keybind) customKeybindings
  );
in
{
  # GNOME desktop configuration (equivalent to your scripts/gnome/ files)
  dconf.settings = lib.mergeAttrs {
    # Window manager keybindings (from keybinds.sh)
    "org/gnome/desktop/wm/keybindings" = lib.mergeAttrs {
      close = [ "<Super>c" ];
      maximize = [ "<Super>Up" ];
      toggle-fullscreen = [ "<Shift>F11" ];
    } (mkWorkspaceKeybindings 6);

    # Workspace settings
    "org/gnome/mutter" = {
      dynamic-workspaces = false;
    };

    "org/gnome/desktop/wm/preferences" = {
      num-workspaces = 6;
      resize-with-right-button = true;
    };

    # Disable Super+number for applications (to use for workspaces)
    "org/gnome/shell/keybindings" = mkDisableAppShortcuts 9;

    # Custom keybindings (from your keybinds.sh)
    "org/gnome/settings-daemon/plugins/media-keys" = {
      custom-keybindings = mkCustomKeybindingPaths (lib.length customKeybindings);
    };
  } customKeybindingSettings;
}
