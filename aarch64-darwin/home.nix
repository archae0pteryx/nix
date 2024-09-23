{ lib, pkgs, ... }:
let
  google-cloud-sdk = pkgs.google-cloud-sdk.withExtraComponents
    [ pkgs.google-cloud-sdk.components.gke-gcloud-auth-plugin ];
in {
  home.stateVersion = "24.11";

  home.file = { ".vimrc".source = ../common/vimrc; };
  home.file = { ".tmux.conf".source = ../common/tmux.conf; };

  xdg.configFile."starship.toml".text =
    builtins.readFile ../common/starship.toml;
  xdg.configFile."alacritty/alacritty.toml".text =
    builtins.readFile ../common/alacritty.toml;
  xdg.configFile."fish/completions/devbox".text =
    builtins.readFile ../common/fish/completions/devbox;

  home.sessionVariables = { EDITOR = "vim"; };
  home.packages = [
    (pkgs.nerdfonts.override { fonts = [ "FiraCode" ]; })
    google-cloud-sdk
    pkgs.devbox
    pkgs.discord
    pkgs.fishPlugins.fzf
    pkgs.fishPlugins.z
    pkgs.fzf
    pkgs.go
    pkgs.jq
    pkgs.k9s
    pkgs.keepassxc
    pkgs.kitty
    pkgs.kubectl
    pkgs.kubectx
    pkgs.kubernetes-helm
    pkgs.logseq
    pkgs.nixfmt-classic
    pkgs.nmap
    pkgs.obsidian
    pkgs.opentofu
    pkgs.pipx
    pkgs.postman
    pkgs.python311
    pkgs.slack
    pkgs.speedtest-cli
    pkgs.spotify
    pkgs.stern
    pkgs.teller
    pkgs.terraform
    pkgs.terragrunt
  ];
  programs.direnv.enable = true;
  programs.direnv.enableFishIntegration = true;
  
  programs.home-manager.enable = true;

  programs.vscode.enable = true;
  programs.vscode.extensions = [ pkgs.vscode-extensions.bbenoist.nix ];

  programs.starship.enable = true;
  programs.git = import ../common/git.nix;
  programs.gh = {
    enable = true;
    gitCredentialHelper.enable = true;
  };
  programs.gpg.enable = true;
  programs.ssh = {
    enable = true;
    forwardAgent = true;
  };
}
