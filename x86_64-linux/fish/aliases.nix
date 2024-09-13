{
  shellAliases = {
    nixconfig = "code $HOME/.config/home-manager";
    nixupdate =
      "sudo -i nix-channel --update && sudo -i nixos-rebuild switch && home-manager switch --flake $HOME/.config/home-manager";
    nixclean = "sudo -i nix-collect-garbage -d && sudo -i nix-store --optimise";
    activatefish = "source .venv/bin/activate.fish";
  };
}
