{
  description = "Darwin configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    darwin.url = "github:lnl7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    # mac-app-util.url = "github:hraban/mac-app-util";
  };

  outputs = inputs@{ nixpkgs, home-manager, darwin, ... }:
    let
      systemConfigs = {
        eyepop = {
          systemArch = "aarch64";
          systemUser = "ryan";
          hostname = "eyepop";
        };
        claire = {
          systemArch = "x86_64";
          systemUser = "rimraf";
          hostname = "claire";
        };
      };
    in {
      darwinConfigurations = builtins.mapAttrs (name: config:
        darwin.lib.darwinSystem {
          specialArgs = {
            inherit (config) systemArch systemUser hostname;
            userHome = "/Users/${config.systemUser}";
          };

          system = "${config.systemArch}-darwin";

          modules = [
            ./configuration.nix
            # "${config.hostname}/configuration.nix"

            # mac-app-util.darwinModules.default
            home-manager.darwinModules.home-manager
          ];
        }) systemConfigs;
    };
}
