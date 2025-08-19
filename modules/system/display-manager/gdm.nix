{
  config,
  pkgs,
  inputs,
  ...
}:
{
  services.displayManager = {
    gdm = {
      enable = true;
    };
  };
}
