{ config, pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;

    # Interactive shell initialization (sourced in .zshrc)
    interactiveShellInit = ''
      # NVM setup
      export NVM_DIR="$([ -z "''${XDG_CONFIG_HOME-}" ] && printf %s "''${HOME}/.nvm" || printf %s "''${XDG_CONFIG_HOME}/nvm")"
      [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

      # FZF keybindings
      if [ -n "''${commands[fzf-share]}" ]; then
        source "$(fzf-share)/key-bindings.zsh"
        source "$(fzf-share)/completion.zsh"
      fi

      # History settings
      HISTSIZE=10000
      SAVEHIST=10000
      setopt SHARE_HISTORY
      setopt HIST_IGNORE_DUPS
      setopt HIST_IGNORE_SPACE

      # Keybindings
      bindkey -e
      bindkey '^[[A' history-search-backward
      bindkey '^[[B' history-search-forward
      bindkey '^R' history-incremental-search-backward
    '';

    # Shell aliases
    shellAliases = {
      # Navigation
      l = "ls -la";
      ".." = "cd ..";
      "..." = "cd ../..";
      "...." = "cd ../../..";

      # Git
      ga = "git add";
      gc = "git commit";
      gp = "git push";
      gco = "git checkout";
      gs = "git status";
      gd = "git diff";

      # Docker
      dc = "docker compose";
      dcb = "docker compose build";
      dcd = "docker compose down";
      dcu = "docker compose up";

      # Tools
      k = "kubectl";
      tf = "terraform";
      vim = "nvim";
    };
  };

  # Environment variables available to all users
  environment.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
    GOPATH = "$HOME/go";
    GOBIN = "$HOME/go/bin";
  };

  # Ensure PATH includes common directories
  environment.systemPackages = with pkgs; [
    zsh-autosuggestions
    zsh-syntax-highlighting
  ];
}
