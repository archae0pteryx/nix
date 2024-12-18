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
  # ids.uids.nixbld = 300;
  ids.uids = import ./${hostname}/nixbld.nix;

  nix.package = pkgs.nix;
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';
  environment.systemPackages = with pkgs; [ vim tmux rustup ];
  environment.shells = [ pkgs.bash pkgs.zsh ];
  environment.variables = {
    EDITOR = "nvim";
    CARGO_HOME = "${userHome}/.cargo";
    GOPATH = "${userHome}/Code/go";
    GOBIN = "${userHome}/Code/go/bin";
    PATH = "${userHome}/.local/bin:${userHome}/Code/go/bin:${userHome}/.cargo/bin:/opt/homebrew/bin:$PATH";
    PKG_CONFIG_PATH = "${pkgs.pkg-config}/lib/pkgconfig:/opt/homebrew/lib/pkgconfig:$PKG_CONFIG_PATH";
    LD_LIBRARY_PATH = "${pkgs.pkg-config}/lib:/opt/homebrew/lib:$LD_LIBRARY_PATH";
    NVM_DIR = "${userHome}/.nvm";
    GSETTINGS_SCHEMA_DIR = "/usr/local/share/glib-2.0/schemas";
    KUBECTL_EXTERNAL_DIFF = "meld";
    XDG_DATA_DIR = "${pkgs.xdg-user-dirs}/share";
  };
  nixpkgs.config.allowUnfree = true;
  # nixpkgs.config.permittedInsecurePackages = [
  #   "electron-27.3.11"
  # ];
  services.nix-daemon.enable = true;

  programs.zsh.enable = true;
  programs.bash.enable = true;
  users = {
    groups.docker = { members = [ "${systemUser}" ]; };
    users.${systemUser} = {
      name = "${systemUser}";
      home = "/Users/${systemUser}";
      shell = pkgs.zsh;
      openssh.authorizedKeys.keyFiles = [
        ../common/ssh/claire.local.pub
        ../common/ssh/eyepop.local.pub
        ../common/ssh/nixos.local.pub
      ];
    };
  };

  homebrew = import ../common/homebrew.nix { inherit hostname; };
  system = import ./system-prefs.nix { inherit hostname; };
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.${systemUser} = combinedHomeManager;
  };
}
