{
  config,
  pkgs,
  ...
}:
{
  home.packages = [
    pkgs.git
  ];

  # Git configuration
  programs.git = {
    enable = true;

    # User information (from your init.sh)
    userName = "cartier";
    userEmail = "cartierhacks@gmail.com";

    # Git settings
    extraConfig = {
      init = {
        defaultBranch = "main";
      };

      core = {
        editor = "code --wait";
        autocrlf = "input";
        ignorecase = false;
      };

      pull = {
        rebase = true;
      };

      push = {
        default = "simple";
        autoSetupRemote = true;
      };

      merge = {
        tool = "code";
      };

      diff = {
        tool = "code";
      };

      # Better diff output
      color = {
        ui = true;
      };
    };
  };
}
