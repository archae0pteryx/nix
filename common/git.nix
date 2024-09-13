{
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
}