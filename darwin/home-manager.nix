{ ... }:
{
  imports = [ ./pkgs.nix ./programs.nix ];
  home.stateVersion = "24.11";
  home.file = { ".vimrc".source = ../common/vimrc; };
  home.file = { ".tmux.conf".source = ../common/tmux.conf; };

  xdg.configFile."starship.toml".text =
    builtins.readFile ../common/starship.toml;
  xdg.configFile."alacritty/alacritty.toml".text =
    builtins.readFile ../common/alacritty.toml;
  #xdg.configFile."fish/completions/devbox".text =
  #  builtins.readFile ../common/fish/completions/devbox;
  # xdg.configFile."amethyst/amethyst.yml".text =
  #   builtins.readFile ../common/amethyst.yml;
  home.sessionVariables = { EDITOR = "vim"; };
}
