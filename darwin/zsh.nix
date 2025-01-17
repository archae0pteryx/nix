{ hostname, ... }: {
  enable = true;
  enableCompletion = true;
  autosuggestion.enable = true;
  autocd = true;
  antidote.enable = true;
  antidote.plugins = [ "agkozak/zsh-z" ];
  shellAliases = import ./${hostname}/extra-aliases.nix;
  syntaxHighlighting.enable = true;
  initExtra = ''
    . "$HOME/.cargo/env"
    
    source <(fzf --zsh)
    
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    [ -s "$NVM_DIR/zsh_completion" ] && \. "$NVM_DIR/zsh_completion"

    manage_tmux_session() {
        if ! command -v tmux &> /dev/null; then
            echo "tmux is not installed. Please install tmux to use this feature."
            return
        fi

        if [ -z "$TMUX" ]; then
            SESSION="foobar"
            tmux new-session -s "$SESSION"
        fi
    }

    case $- in
        *i*)
            manage_tmux_session
            ;;
        *)
            ;;
    esac

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
  '';
}
