{ hostname, pkgs, ... }: 
{
  programs.home-manager.enable = true;

  programs.vscode.enable = true;
  programs.vscode.extensions = [ pkgs.vscode-extensions.bbenoist.nix ];

  programs.starship = {
    enable = true;
    starship.enableNushellIntegration = true;
    starship.enableZshIntegration = true;
    starship.enableBashIntegration = true;
  };
  
  programs.git = import ../common/git.nix;
  programs.gh = {
    enable = true;
    gitCredentialHelper.enable = true;
  };
  programs.gpg.enable = true;
  programs.ssh = {
    enable = true;
    forwardAgent = true;
  };
  programs.zsh = import ./zsh.nix;
}
