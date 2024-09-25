{ lib, pkgs, mac-app-util, ... }:
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
    pkgs.argo
    pkgs.argocd
    pkgs.awscli
    pkgs.colima
    pkgs.devbox
    pkgs.discord
    pkgs.docker
    pkgs.fishPlugins.fzf
    pkgs.fishPlugins.z
    pkgs.ffmpeg
    pkgs.fzf
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
    pkgs.autoconf
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
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    autocd = true;
    antidote.enable = true;
    antidote.plugins = ["agkozak/zsh-z"];
    envExtra = ''
alias rebuild='darwin-rebuild switch --flake $HOME/.config/nix/aarch64-darwin'
alias nixconfig='code $HOME/.config/nix'
alias hammerconfig='code $HOME/.hammerspoon'
alias l='ls -hal'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias dc='docker compose'
alias dcb='docker compose build'
alias dcd='docker compose down'
alias alacrittyconfig='code $HOME/.config/alacritty'
alias kittyconfig='code $HOME/.config/kitty'
alias c='cd $HOME/Code'
alias ga='git add'
alias gc='git commit -S -m'
alias gp='git push'
alias gco='git checkout'
alias sess='$HOME/.config/nix/common/scripts/sessionizer.sh'
alias activatefish='source .venv/bin/activate.fish'
alias tf='tofu'
alias tfa='tofu apply'
alias tfd='tofu destroy'
alias tfp='tofu plan'
alias tfda='tofu destroy -auto-approve'
alias tfaa='tofu apply -auto-approve'
alias tg='terragrunt'
alias tga='terragrunt apply'
alias tgp='terragrunt plan'

export PATH=$HOME/.local/bin:$PATH
export GOPATH=$HOME/Code/go
export GOBIN=$GOPATH/bin
export PATH=$GOPATH/bin:$PATH

$HOME/.config/nix/common/scripts/tmux_auto_attach.sh
source <(fzf --zsh)
    '';
  };
}
