{ lib, config, pkgs, ... }:
let
  commonFish = import ../common/fish { };
  macFishAliases = import ./aliases.nix { };
  mergedFish = lib.recursiveUpdate commonFish macFishAliases;
in
{
  # remove before upgrading to sequoia
  ids.uids.nixbld = 300;
  nix.package = pkgs.nix;
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';
  environment.systemPackages = with pkgs; [ vim tmux  rustup];
  environment.shells = [ pkgs.fish pkgs.bash pkgs.zsh ];
  nixpkgs.config.allowUnfree = true;
  # nixpkgs.config.permittedInsecurePackages = [
  #   "electron-27.3.11"
  # ];
  services.nix-daemon.enable = true;

  programs.zsh.enable = true;
  programs.fish = mergedFish;
  programs.bash.enable = true;

  # programs.bash = {
  #   interactiveShellInit = ''
  #     if [[ $(${pkgs.procps}/bin/ps -p $PPID -o command | tail -n +2) != "fish" && -z $BASH_EXECUTION_STRING ]]
  #     then
  #       shopt -q login_shell && LOGIN_OPTION="--login" || LOGIN_OPTION=""
  #       exec fish $LOGIN_OPTION
  #     fi
  #   '';
  # };
 
  users.users.ryan = {
    name = "ryan";
    home = "/Users/ryan";
    shell = pkgs.zsh;
  };
  homebrew = import ./homebrew.nix;
  system = import ./system.nix;
}
