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
  xdg.configFile."config/alacritty.toml".text =
    builtins.readFile ../common/alacritty.toml;
  xdg.configFile."kitty/kitty.conf".text = builtins.readFile ../common/kitty.conf;
  # xdg.configFile."amethyst/amethyst.yml".text =
  #   builtins.readFile ../common/amethyst.yml;
  
}
