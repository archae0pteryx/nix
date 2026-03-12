{
  rebuild = "darwin-rebuild switch --flake $HOME/.config/nix/darwin#claire";
  nixcheck = "darwin-rebuild build --flake $HOME/.config/nix/darwin#claire";
  hammerconfig = "code $HOME/.hammerspoon";
}
