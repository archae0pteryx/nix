{ lib }:
{
  home-manager.enable = true;
  gpg.enable = true;
  ssh = {
    enable = true;
    forwardAgent = true;
  };

  # fish = mergedFish;
  zsh = import ./zsh.nix;
  go = {
    enable = true;
    goPath = "/home/rimraf/Code/go";
    goBin = "/home/rimraf/Code/go/bin";
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
      core.excludesfile = "~/.gitignore";
      color.ui = "auto";
      commit.gpgsign = true;
      gpg.format = "ssh";
      user.signingkey = "~/.ssh/signing_rsa.pub";
      push.autoSetupRemote = true;
    };
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
