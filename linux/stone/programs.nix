{ pkgs }: {
  home-manager.enable = true;

  zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    autocd = true;
    syntaxHighlighting.enable = true;

    antidote = {
      enable = true;
      plugins = [ "agkozak/zsh-z" ];
    };

    shellAliases = {
      l = "ls -hal";
      ".." = "cd ..";
      "..." = "cd ../..";
      c = "cd ~/Code";
      ga = "git add";
      gc = "git commit -m";
      gp = "git push";
      gco = "git checkout";
      gs = "git status";
    };

    initContent = ''
      # Keybindings
      bindkey '^F' end-of-line
      bindkey '^A' beginning-of-line
      bindkey '^E' autosuggest-accept

      # Tool init
      command -v fzf &>/dev/null && source <(fzf --zsh)
      command -v gh &>/dev/null && source <(gh completion -s zsh)

      # Cargo
      [ -s "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"
    '';
  };

  delta = {
    enable = true;
    enableGitIntegration = true;
    options = {
      navigate = true;
      line-numbers = true;
      side-by-side = true;
    };
  };

  git = {
    enable = true;
    ignores = [
      ".DS_Store"
      "node_modules"
      "tmp"
      ".venv"
      "venv"
      ".vscode"
      ".idea"
      ".terraform"
      ".terragrunt-cache"
      "__pycache__"
      ".pytest_cache"
      ".env"
      "*.secret*"
      ".claude"
      ".cursor"
      ".devbox"
    ];
    settings = {
      user.name = "archae0pteryx";
      user.email = "github@pocketcereal.com";
      init.defaultBranch = "main";
      pull.rebase = true;
      push.autoSetupRemote = true;
      core.editor = "nvim";
      merge.conflictstyle = "diff3";
      color.ui = "auto";
      rerere.enabled = true;

      # Commit signing with SSH key
      # TODO: Generate key on stone: ssh-keygen -t ed25519 -f ~/.ssh/signing_ed25519 -C "git-signing"
      #       Then add public key to GitHub: Settings > SSH and GPG keys > New SSH key (type: Signing Key)
      commit.gpgsign = true;
      gpg.format = "ssh";
      user.signingkey = "~/.ssh/signing_ed25519.pub";
    };
  };

  gh = {
    enable = true;
    settings.git_protocol = "ssh";
    gitCredentialHelper.enable = true;
  };

  ssh = {
    enable = true;
    enableDefaultConfig = false;
    matchBlocks."*" = {
      forwardAgent = true;
    };
  };

  gpg.enable = true;
}
