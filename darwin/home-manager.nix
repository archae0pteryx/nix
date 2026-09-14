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
    "Scripts" = {
      source = ../common/scripts;
      recursive = true;
    };
  };

  xdg.configFile = {
    "vim/vimrc".source = ../common/vimrc;
    "tmux/tmux.conf".source = ../common/tmux.darwin.conf;
    "nvim/init.lua".source = ../common/nvim/init.lua;
    "starship.toml".source = ../common/starship.toml;
  };

  home.sessionPath = [
    "${brewPrefix}/bin"
    "${brewPrefix}/sbin"
    "${brewPrefix}/opt/mysql-client@8.0/bin"
    "${userHome}/.local/bin"
    "${userHome}/.bun/bin"
    "${userHome}/.cargo/bin"
    "${userHome}/Code/go/bin"
  ] ++ extraPaths;
}
