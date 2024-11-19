{ userHome, ... }: {
  enable = true;
  userName = "archae0pteryx";
  userEmail = "github@pocketcereal.com";
  diff-so-fancy.enable = true;
  extraConfig = {
    init.defaultBranch = "main";
    pull.rebase = "true";
    core.editor = "code --wait";
    core.excludesfile = "${userHome}/.gitignore";
    color.ui = "auto";
    commit.gpgsign = true;
    gpg.format = "ssh";
    user.signingkey = "${userHome}/.ssh/signing_ed25519.pub";
    push.autoSetupRemote = true;
    rerere.enabled = true;
    diff.tool = "meld";
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
    "___*"
    ".env"
    "*.secret*"
  ];
}
