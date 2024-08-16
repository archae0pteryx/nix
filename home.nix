{ config, pkgs, ... }:
let
  google-cloud-sdk = pkgs.google-cloud-sdk.withExtraComponents [pkgs.google-cloud-sdk.components.gke-gcloud-auth-plugin];
in
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
    google-cloud-sdk
    pkgs.bitwarden
    pkgs.starship
    pkgs.vscode
    pkgs.keepassxc
    pkgs.devbox
    pkgs.nixfmt-classic
    pkgs.fishPlugins.z
    pkgs.fishPlugins.fzf-fish
    pkgs.kubectl
    pkgs.opentofu
    pkgs.terragrunt
    pkgs.kubectx
    pkgs.fzf
    pkgs.mullvad-vpn
    pkgs.teller
    pkgs.brave
    pkgs.ffmpeg
    pkgs.tdrop
    pkgs.alacritty
    pkgs.tmux
    pkgs.nmap
    pkgs.postman
    pkgs.beekeeper-studio
    pkgs.ripgrep
    pkgs.fd
    pkgs.dnsutils
    pkgs.xsel
    pkgs.jq
    pkgs.k9s
    pkgs.xfce.xfce4-pulseaudio-plugin
    pkgs.emojipick
    pkgs.python311
    pkgs.xclip
    pkgs.dmenu
    pkgs.kubernetes-helm
    (pkgs.nerdfonts.override { fonts = [ "FiraCode" ]; })
  ];

  home.file = { ".vimrc".source = ./dotfiles/vimrc; };
  home.file = { ".tmux.conf".source = ./dotfiles/tmux.conf; };
  xdg.configFile."starship.toml".text = builtins.readFile ./dotfiles/starship.toml; 
  xdg.configFile."copyq/copyq.conf".text = builtins.readFile ./dotfiles/copyq.conf;
  xdg.configFile."xfce4/xfconf/xfce-perchannel-xml/xfce4-keyboard-shortcuts.xml".text = builtins.readFile ./xfce4/xfce4-keyboard-shortcuts.xml;

  programs = import ./programs.nix;

  services.gpg-agent = { enable = true; enableSshSupport = true; };
  services.copyq.enable = true;
}
