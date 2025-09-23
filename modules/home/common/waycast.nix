{
  pkgs,
  config,
  inputs,
  ...
}:

{
  imports = [ inputs.waycast.homeManagerModules.default ];
  programs.waycast = {
    enable = true;
    enableDaemon = true;
    settings = {
      plugins.projects = {
        open_command = "code -n {path}";
        search_paths = [
          "/home/cartier/repos"
        ];
      };
    };
  };
}
