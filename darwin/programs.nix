{ userHome, hostname, pkgs, ... }: {
  programs.home-manager.enable = true;

  programs.vscode.enable = true;
  programs.vscode.extensions = [ pkgs.vscode-extensions.bbenoist.nix ];

  programs.starship = {
    enable = true;
    enableNushellIntegration = true;
    enableZshIntegration = true;
    enableBashIntegration = true;
  };

  programs.git = import ../common/git.nix { inherit userHome; };
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
