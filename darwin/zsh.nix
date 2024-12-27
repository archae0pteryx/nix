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

  '';
}
