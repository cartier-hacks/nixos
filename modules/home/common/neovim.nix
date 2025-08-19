# neovim.nix
{
  config,
  pkgs,
  inputs,
  ...
}:

{
  home.packages = [
    inputs.neovim-nightly-overlay.packages.${pkgs.system}.default
  ];
}
