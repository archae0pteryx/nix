{ pkgs, hostname, ... }:
let
  extraPkgs = import ./${hostname}/extra-pkgs.nix { inherit pkgs; };
in {
  home.packages = [
    # (pkgs.nerdfonts.override { fonts = [ "FiraCode" ]; })
    pkgs.devbox
    pkgs.dnsutils
    pkgs.docker
    pkgs.ffmpeg
    pkgs.fzf
    pkgs.go
    pkgs.go-task
    pkgs.kubectl
    pkgs.kubectx
    pkgs.kubernetes-helm
    pkgs.neovim
    pkgs.nerd-fonts.fira-code
    pkgs.nixfmt-classic
    pkgs.nmap
    pkgs.stern
  ] ++ extraPkgs;
}
