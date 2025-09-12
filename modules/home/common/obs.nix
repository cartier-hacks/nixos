{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    (obs-studio.override {
      cudaSupport = true;
    })
  ];

  xdg.configFile."obs-studio" = {
    source = ./obs-config;
    recursive = true;
    force = true;
  };
}
