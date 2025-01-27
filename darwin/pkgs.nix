{ pkgs, ... }:
let
  google-cloud-sdk = pkgs.google-cloud-sdk.withExtraComponents
    [ pkgs.google-cloud-sdk.components.gke-gcloud-auth-plugin ];
in {
  home.packages = [
    (pkgs.nerdfonts.override { fonts = [ "FiraCode" ]; })
    google-cloud-sdk
    pkgs.argo
    pkgs.argocd
    pkgs.autoconf
    pkgs.awscli
    pkgs.chromedriver
    pkgs.cmake
    pkgs.colima
    pkgs.devbox
    pkgs.dive
    pkgs.dnsutils
    pkgs.docker
    pkgs.ffmpeg
    pkgs.fzf
    pkgs.geckodriver
    pkgs.go
    pkgs.jq
    pkgs.k9s
    pkgs.keepassxc
    pkgs.kind
    pkgs.kubectl
    pkgs.kubectx
    pkgs.kubernetes-helm
    pkgs.meld
    pkgs.neovim
    pkgs.nixfmt-classic
    pkgs.nmap
    pkgs.ollama
    pkgs.openssl
    pkgs.opentofu
    pkgs.pkg-config
    pkgs.pipx
    pkgs.qbittorrent
    pkgs.realvnc-vnc-viewer
    pkgs.slack
    pkgs.speedtest-cli
    pkgs.spotify
    pkgs.stern
    pkgs.teller
    pkgs.terraform
    pkgs.terragrunt
    pkgs.zoom-us
  ];
}
