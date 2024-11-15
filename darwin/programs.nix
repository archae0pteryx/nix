{ ... }: {
  programs.home-manager.enable = true;

  programs.vscode.enable = true;
  programs.vscode.extensions = [ pkgs.vscode-extensions.bbenoist.nix ];

  programs.starship.enable = true;
  programs.starship.enableNushellIntegration = true;
  #programs.starship.enableFishIntegration = true;
  programs.starship.enableZshIntegration = true;
  programs.starship.enableBashIntegration = true;

  programs.git = import ../common/git.nix;
  programs.gh = {
    enable = true;
    gitCredentialHelper.enable = true;
  };
  programs.nushell = {
    enable = true;
    # loginFile.source = "../common/nushell.nu";
    shellAliases = {
      rebuild =
        "darwin-rebuild switch --flake /Users/ryan/.config/nix/aarch64-darwin";
      nixconfig = "code /Users/ryan/.config/nix";
      hammerconfig = "code /Users/ryan/.hammerspoon";
      l = "ls -hal";
      dc = "docker compose";
      dcb = "docker compose build";
      dcd = "docker compose down --remove-orphans";
      dcu = "docker compose up";
      dcdv = "docker compose down --remove-orphans -v";
      alacrittyconfig = "code /Users/ryan/.config/alacritty";
      kittyconfig = "code /Users/ryan/.config/kitty";
      c = "cd /Users/ryan/Code";
      ga = "git add";
      gc = "git commit -S -m";
      gp = "git push";
      gco = "git checkout";
      sess = "/Users/ryan/.config/nix/common/scripts/sessionizer.sh";
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
      codespace = "code /Users/ryan/Code/eyepop/eyepop.code-workspace";
      p = "ping 8.8.8.8";
      kapply = "devbox run kapply";
      kdiff = "devbox run kdiff";
    };
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
      dcd = "docker compose down --remove-orphans";
      dcu = "docker compose up";
      dcdv = "docker compose down --remove-orphans -v";
      alacrittyconfig = "code $HOME/.config/alacritty";
      kittyconfig = "code $HOME/.config/kitty";
      c = "cd $HOME/Code";
      ga = "git add";
      gc = "git commit -S -m";
      gp = "git push";
      gco = "git checkout";
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
      kapply = "devbox run kapply";
      kdiff = "devbox run kdiff";
      patternconfig = "code $HOME/.config/fabric";
      fabshell = "fabric -p shell";
      fabp = "fabric -p";
      autoattach = "$HOME/.config/nix/common/scripts/tmux_auto_attach.sh";
      sess = "$HOME/.config/nix/common/scripts/sessionizer.sh";
    };
    syntaxHighlighting.enable = true;
    envExtra = ''
      export PATH=$HOME/.local/bin:$PATH
      export GOPATH=$HOME/Code/go
      export GOBIN=$GOPATH/bin
      export PATH=$GOPATH/bin:$PATH
      source <(fzf --zsh)
      eval "$(/opt/homebrew/bin/brew shellenv)"
      export PKG_CONFIG_PATH=$(pkg-config --variable pc_path pkg-config)
      export NVM_DIR="$HOME/.nvm"
      [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
      [ -s "$NVM_DIR/zsh_completion" ] && \. "$NVM_DIR/zsh_completion"
    '';
  };
}
