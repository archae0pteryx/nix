{ pkgs, ... }: {
  home.stateVersion = "24.11";
  programs.home-manager.enable = true;
  programs.vscode.enable = true;
  programs.vscode.extensions = [ pkgs.vscode-extensions.bbenoist.nix ];
  programs.fish.enable = true;
  programs.starship.enable = true;
  xdg.configFile."starship.toml".text = builtins.readFile ../common/starship.toml; 
 }
