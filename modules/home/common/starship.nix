{
  config,
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    starship
  ];

  # Starship prompt configuration (equivalent to your starship-prompt.sh)
  programs.starship = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;

    settings = {
      character = {
        success_symbol = "[† ❯](bold green)";
        error_symbol = "[€ ❯](bold red)";
      };

      directory = {
        truncation_length = 9;
      };

      php = {
        format = "[$symbol($version )]($style)";
      };

      golang = {
        format = "[$symbol($version )]($style)";
      };

      nodejs = {
        format = "[$symbol($version )]($style)";
      };

      bun = {
        format = "[$symbol($version )]($style)";
      };
    };
  };
}
