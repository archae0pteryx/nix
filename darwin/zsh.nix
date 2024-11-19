{ hostname, ... }: {
  enable = true;
  enableCompletion = true;
  autosuggestion.enable = true;
  autocd = true;
  antidote.enable = true;
  antidote.plugins = [ "agkozak/zsh-z" ];
  shellAliases = import ./${hostname}/extra-aliases.nix;
  syntaxHighlighting.enable = true;
  envExtra = ''
    source <(fzf --zsh)
    eval "$(/opt/homebrew/bin/brew shellenv)"
    export PATH=$HOME/.local/bin:$PATH
    export GOPATH=$HOME/Code/go
    export GOBIN=$GOPATH/bin
    export PATH=$GOPATH/bin:$PATH
    export PKG_CONFIG_PATH=$(pkg-config --variable pc_path pkg-config)
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    [ -s "$NVM_DIR/zsh_completion" ] && \. "$NVM_DIR/zsh_completion"
  '';
}
