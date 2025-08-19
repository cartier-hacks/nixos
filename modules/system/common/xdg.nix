{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:
{

  # Configure all the xdg stuff so apps work correctly
  xdg = {
    portal = {
      enable = true;
      extraPortals = [
        pkgs.xdg-desktop-portal-gtk
        pkgs.xdg-desktop-portal-hyprland
      ];
    };
  };
}
