{ lib, config }:
let
  home = config.home.homeDirectory;
in {
  home-manager.enable = true;
  gpg.enable = true;
  ssh = {
    enable = true;
    forwardAgent = true;
    includes = [ "config.d/*" ];
  };

  # fish = mergedFish;
  zsh = import ./zsh.nix;
  go = {
    enable = true;
    goPath = "${home}/Code/go";
    goBin = "${home}/Code/go/bin";
  };
  gh = {
    enable = true;
    gitCredentialHelper.enable = true;
  };
  rbw = {
    enable = true;
    settings.email = "bitwarden@pocketcereal.com";
  };
  git = {
    enable = true;
    userName = "archae0pteryx";
    userEmail = "github@pocketcereal.com";
    diff-so-fancy.enable = true;
    extraConfig = {
      init.defaultBranch = "main";
      pull.rebase = "false";
      core.editor = "code --wait";
      core.autocrlf = "input";
      color.ui = "auto";
      commit.gpgsign = true;
      gpg.format = "ssh";
      user.signingkey = "${home}/.ssh/signing_rsa.pub";
      push.autoSetupRemote = true;
    };
    # Written to ~/.config/git/ignore. Do not set core.excludesfile alongside
    # this; that overrides the XDG default and silently strips the whole list.
    # Keep in sync with ~/.dotfiles/git/.config/git/ignore on darwin.
    ignores = [
      "~.*"
      ".DS_Store"
      "node_modules"
      "tmp"
      ".venv"
      "venv"
      ".idea"
      ".terraform"
      ".terragrunt-cache"
      "__pycache__"
      ".pytest_cache"
      ".devbox"
      "___*"
      ".env"
      "*.secret*"
      # Trailing slash matters: a bare `worktree*` also matched any FILE whose
      # name starts with "worktree", silently hiding tracked files.
      ".worktree*/"
      "worktree*/"
    ];
  };
  # direnv.enable = true;
  rofi = {
    enable = true;
    theme = "gruvbox-dark-soft";
    pass.enable = true;
    extraConfig = {
      modi = "combi,window,run";
    };
  };
  i3status-rust.enable = true;
  starship.enable = true;
  starship.enableNushellIntegration = true;
  starship.enableFishIntegration = true;
  starship.enableZshIntegration = true;
  starship.enableBashIntegration = true;
}
