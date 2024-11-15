{ lib, config, pkgs, ... }:
{
  # remove before upgrading to sequoia
  ids.uids.nixbld = 300;

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
 
  users.users.ryan = {
    name = "ryan";
    home = "/Users/ryan";
    shell = pkgs.zsh;
  };

  homebrew = import ../../common/homebrew.nix;
  system = import ../system.nix;
}
