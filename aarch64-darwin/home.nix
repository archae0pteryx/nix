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
  # xdg.configFile."amethyst/amethyst.yml".text =
  #   builtins.readFile ../common/amethyst.yml;
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
    pkgs.dive
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
    pkgs.nushell
    pkgs.obsidian
    pkgs.opentofu
    pkgs.pipx
    pkgs.pkg-config
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
    pkgs.zoom-us
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
    antidote.plugins = [ "agkozak/zsh-z" ];
    shellAliases = {
      rebuild =
        "darwin-rebuild switch --flake $HOME/.config/nix/aarch64-darwin";
      nixconfig = "code $HOME/.config/nix";
      hammerconfig = "code $HOME/.hammerspoon";
      l = "ls -hal";
      ".." = "cd ..";
      "..." = "cd ../..";
      "...." = "cd ../../..";
      dc = "docker compose";
      dcb = "docker compose build";
      dcd = "docker compose down";
      alacrittyconfig = "code $HOME/.config/alacritty";
      kittyconfig = "code $HOME/.config/kitty";
      c = "cd $HOME/Code";
      ga = "git add";
      gc = "git commit -S -m";
      gp = "git push";
      gco = "git checkout";
      sess = "$HOME/.config/nix/common/scripts/sessionizer.sh";
      activatefish = "source .venv/bin/activate.fish";
      tf = "tofu";
      tfa = "tofu apply";
      tfd = "tofu destroy";
      tfp = "tofu plan";
      tfda = "tofu destroy -auto-approve";
      tfaa = "tofu apply -auto-approve";
      tg = "terragrunt";
      tga = "terragrunt apply";
      tgaa = "terragrunt apply -auto-approve";
      tgp = "terragrunt plan";
      tgda = "terragrunt destroy -auto-approve";
      kx = "kubectx";
      k = "kubectl";
      kns = "kubens";
      kc = "kubectl config";
      codespace = "code $HOME/Code/eyepop/eyepop.code-workspace";
      p = "ping 8.8.8.8";
    };
    syntaxHighlighting.enable = true;
    envExtra = ''
      export PATH=$HOME/.local/bin:$PATH
      export GOPATH=$HOME/Code/go
      export GOBIN=$GOPATH/bin
      export PATH=$GOPATH/bin:$PATH

      $HOME/.config/nix/common/scripts/tmux_auto_attach.sh
      source <(fzf --zsh)
      eval "$(/opt/homebrew/bin/brew shellenv)"
      export PKG_CONFIG_PATH=$(pkg-config --variable pc_path pkg-config)
    '';
  };
}
