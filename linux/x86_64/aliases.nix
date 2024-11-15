{}:
let
  shellAliases = {
    rebuild = "home-manager switch --flake $HOME/.config/nix/x86_64-linux";
    nixupdate =
      "sudo -i nix-channel --update && sudo -i nixos-rebuild switch && home-manager switch --flake $HOME/.config/nix/x86_64-linux";
    nixclean = "sudo -i nix-collect-garbage -d && sudo -i nix-store --optimise";
    setmonitors = "/home/rimraf/.config/nix/x86_64-linux/scripts/setup-monitors.sh";
  };

in
{
  inherit shellAliases;
}
