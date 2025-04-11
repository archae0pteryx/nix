{ pkgs, ... }:
let
  google-cloud-sdk = pkgs.google-cloud-sdk.withExtraComponents
    [ pkgs.google-cloud-sdk.components.gke-gcloud-auth-plugin ];
in {

  home.packages = [
    # (pkgs.nerdfonts.override { fonts = [ "FiraCode" ]; })
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
    pkgs.go-task
    pkgs.jq
    pkgs.k9s
    pkgs.kcl
    pkgs.kind
    pkgs.kubectl
    pkgs.kubectx
    pkgs.kubernetes-helm
    pkgs.meld
    pkgs.neovim
    pkgs.nerd-fonts.fira-code
    pkgs.nixfmt-classic
    pkgs.nmap
    pkgs.ollama
    pkgs.openssl
    pkgs.opentofu
    pkgs.pipx
    pkgs.pkg-config
    pkgs.python311
    pkgs.speedtest-cli
    pkgs.stern
    pkgs.teller
    pkgs.terraform
    pkgs.terragrunt
    pkgs.yq
  ];
}
