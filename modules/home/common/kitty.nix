{
  config,
  lib,
  pkgs,
  ...
}:
let
  kittyConfig = ''
    font_size 16.0

    background_opacity 0.7
    background_blur 1

    hide_window_decorations yes

    map ctrl+shift+t new_tab_with_cwd
  '';
in
{
  home.packages = with pkgs; [
    kitty
  ];

  programs.kitty = {
    enable = true;

    extraConfig = kittyConfig;
  };
}
