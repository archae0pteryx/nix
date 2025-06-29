{ userHome, hostname, pkgs, ... }: {
  programs.home-manager.enable = true;
  programs.ripgrep.enable = true;
  programs.starship = {
    enable = true;
    enableNushellIntegration = true;
    enableZshIntegration = true;
    enableBashIntegration = true;
  };

  programs.git = import ../common/git.nix { inherit userHome; };
  programs.gitui = {
    enable = true;
  };
  programs.git-worktree-switcher = {
    enable = true;
    enableZshIntegration = true;
    enableBashIntegration = true;
  };
  programs.gh = {
    enable = true;
    gitCredentialHelper.enable = true;
  };
  programs.gpg.enable = true;
  programs.ssh = {
    enable = true;
    forwardAgent = true;
  };
  programs.zsh = import ./zsh.nix { inherit hostname; };
}
