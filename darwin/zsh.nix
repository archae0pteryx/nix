{ hostname, brewPrefix, userHome, ... }:

let
  extraEnv =
    import ./${hostname}/extra-env.nix { inherit brewPrefix userHome; };
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
    eval "$(brew shellenv)"
    export NVM_DIR="$HOME/.nvm"
    if [ -s "${brewPrefix}/opt/nvm/nvm.sh" ]; then
      # Home Manager and brew shellenv prepend Homebrew ahead of inherited NVM
      # paths in nested shells. nvm reuses existing NVM paths in-place, so clear
      # stale entries first and then put the default version at the front.
      \. "${brewPrefix}/opt/nvm/nvm.sh" --no-use
      nvm deactivate --silent >/dev/null 2>&1 || true
      nvm use --silent default >/dev/null 2>&1 || true
    fi
    [ -s "${brewPrefix}/opt/nvm/etc/bash_completion.d/nvm" ] && \. "${brewPrefix}/opt/nvm/etc/bash_completion.d/nvm"
    command -v fzf &>/dev/null && source <(fzf --zsh)
    command -v starship &>/dev/null && eval "$(starship init zsh)"
    command -v gh &>/dev/null && source <(gh completion -s zsh)
    command -v kubectl &>/dev/null && source <(kubectl completion zsh)
    command -v docker &>/dev/null && source <(docker completion zsh)
    command -v helm &>/dev/null && source <(helm completion zsh)
    command -v kind &>/dev/null && source <(kind completion zsh)

    bindkey '^F' end-of-line
    bindkey '^A' beginning-of-line
    bindkey '^R' history-incremental-search-backward
    bindkey '^P' autosuggest-up
    bindkey '^N' autosuggest-down
    bindkey '^W' backward-kill-word
    bindkey '^U' backward-kill-line
    bindkey '^L' clear-screen
    bindkey '^E' autosuggest-accept
    bindkey '^D' autosuggest-execute

    [ -f "$HOME/.config/env_exports" ] && source "$HOME/.config/env_exports"
    export GOPATH="$HOME/Code/go"
    export GOBIN="$HOME/Code/go/bin"

    export OLLAMA_HOST=https://ollama.kitty-tetra.ts.net
    export CARGO_HOME="$HOME/.cargo"
    export SOPS_AGE_KEY_FILE=$HOME/.config/sops/age/keys.txt
  '';
}
