{
  description = "Darwin configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    darwin.url = "github:lnl7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    mac-app-util.url = "github:hraban/mac-app-util";
  };

  outputs = inputs@{ nixpkgs, home-manager, darwin, mac-app-util, ... }:
    let
      systemConfis = {
        eyepop = {
          system = "aarch64-darwin";
          user = "ryan";
          hostname = "eyepop";
          configRoot = ./aarch64;
        };
      };
    in {
      darwinConfigurations = builtins.mapAttrs (name: config:
        darwin.lib.darwinSystem {
          system = config.system;

          modules = [
            ./configuration.nix

            # System-specific configuration
            "${config.configRoot}/configuration.nix"

            mac-app-util.darwinModules.default
            home-manager.darwinModules.home-manager

            {
              networking.hostname = config.hostname;

              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users.${config.user} = import ../home-manager.nix;
                sharedModules = [ mac-app-util.homeManagerModules.default ];
                backupFileExtension = "nixbak";
              };
            }
          ];
        }) systemConfigs;
    };
}
