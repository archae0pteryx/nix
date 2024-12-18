{
  enable = true;
  enableCompletion = true;
  autosuggestion.enable = true;
  autocd = true;
  antidote.enable = true;
  antidote.plugins = [ "agkozak/zsh-z" ];
  shellAliases = import ./extra-aliases.nix;
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
