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

    source <(podman completion zsh)

    case $- in
        *i*)
            if [ -z "$TMUX" ]; then
                $HOME/Scripts/bin/sessionizer
            fi
            ;;
        *)
            ;;
    esac

  '';
}
