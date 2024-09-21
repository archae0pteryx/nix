{ lib, config, pkgs, ... }:
let
  commonFish = import ../common/fish { };
  macFishAliases = import ./aliases.nix { };
  mergedFish = lib.recursiveUpdate commonFish macFishAliases;
in
{
  nix.package = pkgs.nix;

  environment.systemPackages = with pkgs; [ vim tmux  rustup];
  environment.shells = [ pkgs.fish pkgs.bash pkgs.zsh ];

  # nixpkgs.hostPlatform = "aarch64-apple-darwin";
  nixpkgs.config.allowUnfree = true;
  # nixpkgs.config.permittedInsecurePackages = [
  #   "electron-27.3.11"
  # ];
  services.nix-daemon.enable = true;

  programs.zsh.enable = true;
  programs.fish = mergedFish;
  programs.bash.enable = true;

  programs.bash = {
    interactiveShellInit = ''
      if [[ $(${pkgs.procps}/bin/ps -p $PPID -o command | tail -n +2) != "fish" && -z $BASH_EXECUTION_STRING ]]
      then
        shopt -q login_shell && LOGIN_OPTION="--login" || LOGIN_OPTION=""
        exec fish $LOGIN_OPTION
      fi
    '';
  };

  users.users.ryan = {
    name = "ryan";
    home = "/Users/ryan";
    shell = pkgs.fish;
  };
  homebrew = import ./homebrew.nix;
  system = import ./system.nix;
}
