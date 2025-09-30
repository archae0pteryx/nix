{ pkgs, ... }:
let
  google-cloud-sdk = pkgs.google-cloud-sdk.withExtraComponents
    [ pkgs.google-cloud-sdk.components.gke-gcloud-auth-plugin ];
in {

  home.packages = [
    # (pkgs.nerdfonts.override { fonts = [ "FiraCode" ]; })
    google-cloud-sdk
    pkgs.autoconf
    pkgs.awscli
    pkgs.bun
    pkgs.chromedriver
    pkgs.colima
    pkgs.devbox
    pkgs.dnsutils
    pkgs.docker
    pkgs.ffmpeg
    pkgs.fzf
    pkgs.geckodriver
    pkgs.go
    pkgs.go-task
    pkgs.graphviz
    pkgs.kcl
    pkgs.kubectl
    pkgs.kubectx
    pkgs.kubernetes-helm
    pkgs.neovim
    pkgs.nerd-fonts.fira-code
    pkgs.nixfmt-classic
    pkgs.nmap
    pkgs.openjdk23
    pkgs.openssl
    pkgs.pipx
    pkgs.pkg-config
    pkgs.python311
    pkgs.speedtest-cli
    pkgs.stern
  ];
}
