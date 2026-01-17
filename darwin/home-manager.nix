{ userHome, hostname, pkgs, ... }:
let
  brewPrefix = if pkgs.stdenv.isAarch64 then "/opt/homebrew" else "/usr/local";
  commonAliases = import ../common/aliases.nix;
  extraAliases = import ./${hostname}/extra-aliases.nix;
  mergedAliases = commonAliases // extraAliases;
  extraPaths = import ./${hostname}/extra-paths.nix { inherit brewPrefix; };
in
{
  imports = [ (import ./pkgs.nix { inherit hostname pkgs; }) (import ./programs.nix { inherit hostname pkgs userHome brewPrefix; }) ];
  
  home.sessionVariables = { EDITOR = "vim"; };
  home.shellAliases = mergedAliases;

  home.stateVersion = "24.11";

  home.file = {
    ".vimrc".source = ../common/vimrc;
    ".tmux.conf".source = ../common/tmux.darwin.conf;
    "Scripts" = {
      source = ../common/scripts;
      recursive = true;
    };
  };
  home.sessionPath = [
    "${brewPrefix}/bin"
    "${brewPrefix}/sbin"
    "${userHome}/.local/bin"
    "${userHome}/Code/eyepop/eyepop-cli/bin"
    "${userHome}/.bun/bin"
    "${userHome}/.cargo/bin"
    "${userHome}/Code/go/bin"
  ] ++ extraPaths;
  # xdg.configFile."starship.toml".text =
  #   builtins.readFile ../common/starship.toml;
 # xdg.configFile."alacritty/alacritty.toml".text =
  #  builtins.readFile ../common/alacritty.toml;
#  xdg.configFile."kitty/kitty.conf".text =
 #   builtins.readFile ../common/kitty.conf;
  # xdg.configFile."amethyst/amethyst.yml".text =
  #   builtins.readFile ../common/amethyst.yml;
}
