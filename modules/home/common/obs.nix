{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    obs-studio
  ];

  xdg.configFile."obs-studio" = {
    source = ./obs-config;
    recursive = true;
    force = true;
  };
}
