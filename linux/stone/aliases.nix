# Stone-specific shell aliases
# Imports common aliases and adds/overrides for this machine

let
  common = import ../../common/aliases.nix;
in common // {
  # Stone-specific overrides/additions
  gs = "git status";
  gd = "git diff";
  vim = "nvim";

  # NixOS rebuild
  rebuild = "sudo nixos-rebuild switch --flake ~/.config/nix/linux/stone";
}
