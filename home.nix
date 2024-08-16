{ config, pkgs, ... }:
let
  google-cloud-sdk = pkgs.google-cloud-sdk.withExtraComponents [pkgs.google-cloud-sdk.components.gke-gcloud-auth-plugin];
in
{
  nixpkgs.config.allowUnfree = true;
  
  home.stateVersion = "24.05";
  home.username = "rimraf";
  home.homeDirectory = "/home/rimraf";
  home.sessionVariables = { EDITOR = "vim"; };
  home.packages = import ./packages.nix;

  home.file = { ".vimrc".source = ./dotfiles/vimrc; };
  home.file = { ".config/copyq/copyq.conf".source = ./dotfiles/copyq.conf; };
  home.file = { ".tmux.conf".source = ./dotfiles/tmux.conf; };
  home.file = { ".config/starship.toml".source = ./dotfiles/starship.toml; };

  xdg.configFile."xfce4/xfconf/xfce-perchannel-xml/xfce4-keyboard-shortcuts.xml".text = builtins.readFile xfce4/xfce4-keyboard-shortcuts.xml;
  
  services = import ./services.nix;
  programs = import ./programs.nix;

}
