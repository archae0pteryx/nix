{
    rebuild = "home-manager switch --flake $HOME/.config/nix/linux/nixos";
    nixupdate =
      "sudo -i nix-channel --update && sudo -i nixos-rebuild switch && home-manager switch --flake $HOME/.config/nix/linux/nixos";
    nixclean = "sudo -i nix-collect-garbage -d && sudo -i nix-store --optimise";
    setmonitors = "$HOME/.config/nix/linux/nixos/scripts/setup-monitors.sh";
}
