{
  config,
  pkgs,
  inputs,
  hostname,
  ...
}:
{
  imports = [
    ../common-config.nix
    ./hardware-configuration.nix
  ];

  services.xserver.libinput.enable = true;
  services.gvfs.enable = true;
  services.udisks2.enable = true;
  services.upower.enable = true;
}
