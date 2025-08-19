{
  config,
  pkgs,
  inputs,
  ...
}:
{
  services.xserver.enable = true;
  services.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  environment.systemPackages = with pkgs; [
    gnome-tweaks
  ];
}
