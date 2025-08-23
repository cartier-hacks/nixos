{
  config,
  pkgs,
  inputs,
  ...
}:

{

  home.packages = with pkgs; [
    grimblast
    grim
    slurp
  ];
}
