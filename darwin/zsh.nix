{ hostname, brewPrefix, ... }:

let
  extraEnv = import ./${hostname}/extra-env.nix { inherit brewPrefix; };
in {
  enable = true;
  enableCompletion = true;
  autosuggestion.enable = true;
  autocd = true;
  antidote.enable = true;
  antidote.plugins = [ "agkozak/zsh-z" ];
  syntaxHighlighting.enable = true;
  initExtra = extraEnv + ''
    [ -s "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"

    command -v fzf &>/dev/null && source <(fzf --zsh)
    command -v starship &>/dev/null && eval "$(starship init zsh)"
    command -v gh &>/dev/null && source <(gh completion -s zsh)
    command -v kubectl &>/dev/null && source <(kubectl completion zsh)
    command -v docker &>/dev/null && source <(docker completion zsh)
    command -v helm &>/dev/null && source <(helm completion zsh)
    command -v kind &>/dev/null && source <(kind completion zsh)
    #source $HOME/.config/env_exports
    export GOPATH="$HOME/Code/go"
    export GOBIN="$HOME/Code/go/bin"

    export NVM_DIR="$HOME/.nvm"
    export OLLAMA_HOST=https://ollama.kitty-tetra.ts.net
    export CARGO_HOME="$HOME/.cargo"
    export SOPS_AGE_KEY_FILE=$HOME/.config/sops/age/keys.txt
  '';
}
