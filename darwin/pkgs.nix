{ pkgs, ... }:
let
  google-cloud-sdk = pkgs.google-cloud-sdk.withExtraComponents
    [ pkgs.google-cloud-sdk.components.gke-gcloud-auth-plugin ];
in {
  home.packages = [
    (pkgs.nerdfonts.override { fonts = [ "FiraCode" ]; })
    google-cloud-sdk
    pkgs.alacritty
    pkgs.argo
    pkgs.argocd
    pkgs.audacity
    pkgs.awscli
    pkgs.chromedriver
    pkgs.cmake
    pkgs.colima
    pkgs.devbox
    pkgs.discord
    pkgs.docker
    pkgs.dive
    pkgs.dnsutils
    pkgs.ffmpeg
    pkgs.fzf
    pkgs.geckodriver
    pkgs.go
    pkgs.jq
    pkgs.k9s
    pkgs.keepassxc
    pkgs.kind
    pkgs.kitty
    pkgs.kubectl
    pkgs.kubectx
    pkgs.kubernetes-helm
    pkgs.logseq
    pkgs.meld
    pkgs.nixfmt-classic
    pkgs.nmap
    pkgs.nushell
    pkgs.obsidian
    pkgs.openssl
    pkgs.opentofu
    pkgs.pipx
    pkgs.pkg-config
    pkgs.python311
    pkgs.slack
    pkgs.speedtest-cli
    pkgs.spotify
    pkgs.stern
    pkgs.teller
    pkgs.terraform
    pkgs.terragrunt
    pkgs.autoconf
    pkgs.qbittorrent
    pkgs.utm
    pkgs.zoom-us
  ];
}
