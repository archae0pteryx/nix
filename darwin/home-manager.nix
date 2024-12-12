{ userHome, hostname, pkgs, ... }:
{
  imports = [ ./pkgs.nix (import ./programs.nix { inherit hostname pkgs userHome; }) ];
  
  home.sessionVariables = { EDITOR = "vim"; };
  home.shellAliases = import ../common/aliases.nix;
  
  home.stateVersion = "24.11";

  home.file = { ".vimrc".source = ../common/vimrc; };
  home.file = { ".tmux.conf".source = ../common/tmux.conf; };
  xdg.configFile."starship.toml".text =
    builtins.readFile ../common/starship.toml;
  xdg.configFile."config/alacritty.yaml".text =
    builtins.readFile ../common/alacritty.yaml;
  xdg.configFile."kitty/kitty.conf".text = builtins.readFile ../common/kitty.conf;
  # xdg.configFile."amethyst/amethyst.yml".text =
  #   builtins.readFile ../common/amethyst.yml;
  
}
