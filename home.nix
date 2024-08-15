{ config, pkgs, ... }:

{
  home.stateVersion = "24.05";
  nixpkgs.config.allowUnfree = true;
  home.username = "rimraf";
  home.homeDirectory = "/home/rimraf";
  home.sessionVariables = { EDITOR = "vim"; };
  home.packages = [
    pkgs.git
    pkgs.slack
    pkgs.thunderbird
    pkgs.vscode
    pkgs.spotify
    pkgs.google-cloud-sdk
    pkgs.bitwarden
    pkgs.starship
    pkgs.vscode
    pkgs.keepassxc
    pkgs.devbox
    pkgs.nixfmt-classic
    pkgs.fishPlugins.z
    pkgs.fishPlugins.fzf-fish
    pkgs.kubectl
    pkgs.helm
    pkgs.opentofu
    pkgs.terragrunt
    pkgs.kubectx
    pkgs.fzf
    pkgs.mullvad-vpn
    pkgs.teller
    pkgs.brave
    pkgs.ffmpeg
    (pkgs.nerdfonts.override { fonts = [ "FiraCode" ]; })
  ];

  home.file = { ".vimrc".source = ./dotfiles/vimrc; };
  home.file = { ".config/copyq/copyq.conf".source = ./dotfiles/copyq.conf; };

  xdg.configFile."xfce4/xfconf/xfce-perchannel-xml/xfce4-keyboard-shortcuts.xml".text = builtins.readFile xfce4/xfce4-keyboard-shortcuts.xml;

  programs = import ./programs.nix;

  services.gpg-agent = { enable = true; enableSshSupport = true; };
  services.copyq.enable = true;
}
