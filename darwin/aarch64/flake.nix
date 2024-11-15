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

  outputs = inputs@{ nixpkgs, home-manager, darwin, mac-app-util, ... }: {
    darwinConfigurations = {
      eyepop = darwin.lib.darwinSystem {
        system = "aarch64-darwin";

        modules = [
          ./configuration.nix
          mac-app-util.darwinModules.default
          home-manager.darwinModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.ryan = import ../home-manager.nix;
            home-manager.sharedModules = [ mac-app-util.homeManagerModules.default ];
            home-manager.backupFileExtension = "nixbak";
          }
        ];
      };
    };
  };
}
