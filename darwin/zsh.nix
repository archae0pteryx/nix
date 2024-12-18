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
    . "$HOME/.cargo/env"
    source <(fzf --zsh)
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    [ -s "$NVM_DIR/zsh_completion" ] && \. "$NVM_DIR/zsh_completion"
  '';
  initExtra = ''
  manage_tmux_session() {
      if ! command -v tmux &> /dev/null; then
          echo "tmux is not installed. Please install tmux to use this feature."
          return
      fi

      if [ -z "$TMUX" ]; then
          SESSION="foobar"
          if tmux has-session -t "$SESSION" 2>/dev/null; then
              tmux attach-session -t "$SESSION" \; new-window
          else
              tmux new-session -s "$SESSION"
          fi
      fi
  }

  # Only in interactive mode
  case $- in
      *i*)
          manage_tmux_session
          ;;
      *)
          ;;
  esac
  
  '';
}
