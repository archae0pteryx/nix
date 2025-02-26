{ hostname, ... }: {
  enable = true;
  enableCompletion = true;
  autosuggestion.enable = true;
  autocd = true;
  antidote.enable = true;
  antidote.plugins = [ "agkozak/zsh-z" ];
  syntaxHighlighting.enable = true;
  initExtra = ''
    . "$HOME/.cargo/env"
    
    source <(fzf --zsh)
    
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    [ -s "$NVM_DIR/zsh_completion" ] && \. "$NVM_DIR/zsh_completion"

    source <(podman completion zsh)

    for pattern_file in $HOME/.config/fabric/patterns/*; do
        # Get the base name of the file (i.e., remove the directory path)
        pattern_name=$(basename "$pattern_file")

        # Create an alias in the form: alias pattern_name="fabric --pattern pattern_name"
        alias_command="alias $pattern_name='fabric --pattern $pattern_name'"

        # Evaluate the alias command to add it to the current shell
        eval "$alias_command"
    done

    yt() {
        local video_link="$1"
        fabric -y "$video_link" --transcript
    }

  '';
}
