{
  enable = true;
  enableCompletion = true;
  autosuggestion.enable = true;
  autocd = true;
  antidote.enable = true;
  antidote.plugins = [ "agkozak/zsh-z" ];
  shellAliases = {
    nixconfig = "code $HOME/.config/nix";
    rebuild = "home-manager switch --flake $HOME/.config/nix/darwin";
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
    activate = "source .venv/bin/activate";
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
    fabricconfig = "code $HOME/.config/fabric";
    fabshell = "fabric -p shell";
    fabp = "fabric -p";
    autoattach = "$HOME/.config/nix/common/scripts/tmux_auto_attach.sh";
    sessionizer = "$HOME/.config/nix/common/scripts/sessionizer.sh";
    setmonitors = "$HOME/.config/nix/common/scripts/sessionizer.sh";
  };
  syntaxHighlighting.enable = true;
  envExtra = ''
    export PATH=$HOME/.local/bin:$PATH
    export GOPATH=$HOME/Code/go
    export GOBIN=$GOPATH/bin
    export PATH=$GOPATH/bin:$PATH
    source <(fzf --zsh)
    # export PKG_CONFIG_PATH=$(pkg-config --variable pc_path pkg-config)
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    [ -s "$NVM_DIR/zsh_completion" ] && \. "$NVM_DIR/zsh_completion"
  '';
  initExtra = ''
    bindkey '^F' end-of-line
    bindkey '^A' beginning-of-line
    bindkey '^R' history-incremental-search-backward
    bindkey '^P' up-line-or-history
    bindkey '^N' down-line-or-history
    bindkey '^W' backward-kill-word
    bindkey '^U' backward-kill-line
    bindkey '^L' clear-screen
    bindkey '^E' autosuggest-accept
    bindkey '^D' autosuggest-execute
    bindkey '^P' autosuggest-up
    bindkey '^N' autosuggest-down
    bindkey '^I' autosuggest-accept

    source <(fzf --zsh)
    if [ -z "$TMUX" ]; then
      tmux attach -t TMUX || tmux new -s TMUX
    fi

  '';
}
