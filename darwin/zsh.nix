{ hostname, ... }: 

let
  extraEnv = import ./${hostname}/extra-env.nix;
in {
  enable = true;
  enableCompletion = true;
  autosuggestion.enable = true;
  autocd = true;
  antidote.enable = true;
  antidote.plugins = [ "agkozak/zsh-z" ];
  syntaxHighlighting.enable = true;
  initExtra = extraEnv + ''
    . "$HOME/.cargo/env"

    source <(fzf --zsh)
    eval "$(starship init zsh)"
    source <(gh completion -s zsh)
    source <(kubectl completion zsh)
    source <(docker completion zsh)
    source <(helm completion zsh)
    source <(kind completion zsh)
    source $HOME/.config/env_exports
    export GOPATH="$HOME/Code/go"
    export GOBIN="$HOME/Code/go/bin"
    export KUBECTL_EXTERNAL_DIFF=meld
    export NVM_DIR="$HOME/.nvm"
    export OLLAMA_HOST=https://ollama.kitty-tetra.ts.net
    export CARGO_HOME="$HOME/.cargo"
    [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"
    [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"
  '';
}
