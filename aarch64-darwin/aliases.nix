{}:
let
  shellAliases = {
    nixconfig = "code $HOME/.config/nix";
    rebuild = "darwin-rebuild switch --flake $HOME/.config/nix/aarch64-darwin";
  };
in
{
  inherit shellAliases;
}
