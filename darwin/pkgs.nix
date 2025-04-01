{ pkgs, ... }:
let
  google-cloud-sdk = pkgs.google-cloud-sdk.withExtraComponents
    [ pkgs.google-cloud-sdk.components.gke-gcloud-auth-plugin ];
in {

  home.packages = [
    # (pkgs.nerdfonts.override { fonts = [ "FiraCode" ]; })
    pkgs.nerd-fonts.fira-code
    google-cloud-sdk
    pkgs.argo
    pkgs.argocd
    pkgs.autoconf
    pkgs.awscli
    pkgs.chromedriver
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
    pkgs.kcl
    pkgs.k9s
    pkgs.kind
    pkgs.kubectl
    pkgs.kubectx
    pkgs.kubernetes-helm
    pkgs.pipx
    pkgs.python311
    pkgs.pkg-config
    pkgs.meld
    pkgs.neovim
    pkgs.nixfmt-classic
    pkgs.nmap
    pkgs.ollama
    pkgs.openssl
    pkgs.opentofu
    pkgs.speedtest-cli
    pkgs.stern
    pkgs.teller
    pkgs.terraform
    pkgs.terragrunt
  ];
}
