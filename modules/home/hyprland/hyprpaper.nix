{
  config,
  pkgs,
  inputs,
  assets,
  ...
}:

{
  home.packages = [
    pkgs.hyprpaper
  ];
  # Home Manager
  xdg.configFile."wallpaper.png".source = "${assets}/wallpaper.png";
  services.hyprpaper = {
    enable = true;
    settings = {
      ipc = "on";
      splash = false;
      preload = [
        "/home/cartier/.config/wallpaper.png"
      ];

      wallpaper = [
        ", /home/cartier/.config/wallpaper.png"
      ];
    };
  };
}
