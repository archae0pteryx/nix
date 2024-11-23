{ pkgs, lib, systemArch, systemUser, hostname, userHome, ... }:
let
  homeManager = import ./home-manager.nix {
    inherit pkgs lib systemUser systemArch hostname userHome;
  };

  extraHomeManager =
    import (builtins.toString ./. + "/${hostname}/extra-home-manager.nix") {
      inherit pkgs lib systemUser systemArch hostname userHome;
    };

  combinedHomeManager = lib.recursiveUpdate homeManager extraHomeManager;
in {
  # remove before upgrading to sequoia
  ids.uids.nixbld = 350;

  nix.package = pkgs.nix;
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';
  environment.systemPackages = with pkgs; [ vim tmux rustup ];
  environment.shells = [ pkgs.bash pkgs.zsh ];
  nixpkgs.config.allowUnfree = true;
  # nixpkgs.config.permittedInsecurePackages = [
  #   "electron-27.3.11"
  # ];
  services.nix-daemon.enable = true;

  programs.zsh.enable = true;
  programs.bash.enable = true;

  users.users.${systemUser} = {
    name = "${systemUser}";
    home = "/Users/${systemUser}";
    shell = pkgs.zsh;
    openssh.authorizedKeys.keyFiles = [ 
      ../common/ssh/claire.local.pub
      ../common/ssh/eyepop.local.pub
      ../common/ssh/nixos.local.pub
    ];
  };

  homebrew = import ../common/homebrew.nix;
  system = import ./system-prefs.nix {
    inherit hostname;
  };
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.${systemUser} = combinedHomeManager;
  };
}
