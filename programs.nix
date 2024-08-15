{
  home-manager.enable = true;
  gpg.enable = true;
  ssh = {
    enable = true;
    forwardAgent = true;
  };
  fish = {
    enable = true;
    shellAliases = {
      rebuild = "home-manager switch --flake $HOME/.config/home-manager";
      opensource = "cd $HOME/Code/opensource";
      eyepop = "cd $HOME/Code/eyepop";
      tf = "opentofu";
      tfa = "opentofu apply";
      tfd = "opentofu destroy";
      tfaa = "opentofu apply --auto-approve";
      tg = "terragrunt";
      tga = "terragrunt apply";
      tgd = "terragrunt destroy";
      tgaa = "terragrunt apply --auto-approve";
      ".." = "cd ..";
      "..." = "cd ../..";
      "...." = "cd ../../..";
      dc = "docker compose";
      dcb = "docker compose build";
      dcd = "docker compose down";
      nixconfig =
        "code $HOME/.config/home-manager";
      c = "cd $HOME/Code";
      ga = "git add";
      gc = "git commit -S -m";
      gp = "git push";
      gco = "git checkout";
      nixupdate = "sudo -i nix-channel --update && sudo -i nixos-rebuild switch && home-manager switch --flake ~/.config/home-manager";
      nixclean = "sudo -i nix-collect-garbage -di && sudo -i nix-store --optimise";
    };
  };
  go = {
    enable = true;
    goPath = "$HOME/Code/go";
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
  direnv.enable = true;
  rofi = {
    enable = true;
    theme = "gruvbox-dark-soft";
  };
}
