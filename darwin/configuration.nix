{ pkgs, lib, systemArch, systemUser, hostname, userHome, ... }:
let
  homeManager = import ./home-manager.nix {
    inherit pkgs lib systemUser systemArch hostname userHome;
  };

  extraHomeManager =
    import ./${hostname}/extra-home-manager.nix {
      inherit pkgs lib systemUser systemArch hostname userHome;
    };

  combinedHomeManager = lib.recursiveUpdate homeManager extraHomeManager;
in {
 
#  ids.uids = import ./${hostname}/nixbld.nix;
  ids.gids.nixbld = 350;

  nix.package = pkgs.nix;
  nix.extraOptions = ''
    experimental-features = nix-command flakes
    trusted-users = root ${systemUser}
    sandbox = false
  '';
  environment.systemPackages = [ pkgs.vim pkgs.tmux ];
  environment.shells = [ pkgs.bash pkgs.zsh ];

  nixpkgs.config.allowUnfree = true;

  programs.zsh.enable = true;
  programs.bash.enable = true;
  users = {
    groups.docker = { members = [ "${systemUser}" ]; };
    users.${systemUser} = {
      name = "${systemUser}";
      home = "/Users/${systemUser}";
      shell = pkgs.zsh;
      openssh.authorizedKeys.keyFiles = [
        ../common/ssh/eyepop.local.pub
      ];
    };
  };

  homebrew = import ./homebrew.nix { inherit hostname; };
  system = import ./system-prefs.nix { inherit hostname; };
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.${systemUser} = combinedHomeManager;
  };
}
