{ userHome, ... }: {
  enable = true;
  userName = "archae0pteryx";
  userEmail = "github@pocketcereal.com";
  delta = {
    enable = true;
    options = {
      navigate = true;
      lineNumbers = true;
      sideBySide = true;
      syntaxHighlighting = true;
    };
  };
  extraConfig = {
    init = {
      defaultBranch = "main";
    };
    merge = {
      conflictstyle = "diff3";
    };
    pull = {
      rebase = "true";
    };
    core = {
      editor = "vim";
    };
    color = {
      ui = "auto";
    };
    commit = {
      gpgsign = true;
    };
    gpg = {
      format = "ssh";
    };
    user.signingkey = "${userHome}/.ssh/signing_ed25519.pub";
    push = {
      autoSetupRemote = true;
    };
    rerere = {
      enabled = true;
    };
  };
  ignores = [
    "~.*"
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
    ".claude"
    "CLAUDE*"
    ".cursor"
    ".cursorrules"
    ".cursorignore"
    ".worktree*"
    "___*"
    ".devbox"
  ];
}
