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
    eval "$(starship init zsh)"

    source $HOME/.config/env_exports
    export GOPATH="$HOME/Code/go"
    export GOBIN="$HOME/Code/go/bin"
    export KUBECTL_EXTERNAL_DIFF=meld
    export NVM_DIR="$HOME/.nvm"

    export OLLAMA_HOST=https://ollama.kitty-tetra.ts.net

    [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"
    [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"

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
