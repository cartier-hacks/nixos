{
  description = "cartier's computer configuration";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprshell.url = "git+https://gitgud.foo/thegrind/hypr-shell.git";
    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";

    my-assets = {
      url = "path:./assets";
      flake = false;
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      my-assets,
      ...
    }@inputs:
    let
      system = "x86_64-linux";

      # Common overlays for all hosts
      overlays = [
        inputs.neovim-nightly-overlay.overlays.default
      ];

      # Helper function to create a host configuration
      mkHost =
        hostname: modules:
        nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = {
            inherit inputs;
            inherit hostname; # Pass hostname to modules
            assets = my-assets;
          };
          modules = [
            # Common modules for all hosts
            inputs.home-manager.nixosModules.default
            inputs.stylix.nixosModules.stylix

            # Apply overlays to all hosts
            (
              { config, pkgs, ... }:
              {
                nixpkgs.overlays = overlays;
              }
            )

            # Host config
            ./modules/system/common/fonts.nix
            ./modules/system/common/xdg.nix
            ./hosts/${hostname}
          ]
          ++ modules; # Additional modules passed to mkHost
        };
    in
    {
      nixosConfigurations = {
        desktop = mkHost "desktop" [
          ./modules/system/nvidia.nix
          ./modules/system/display-manager/sddm.nix
          ./modules/system/gaming.nix
        ];

        laptop = mkHost "laptop" [
          ./modules/system/display-manager/sddm.nix
        ];
      };
    };
}
