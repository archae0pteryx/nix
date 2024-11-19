{
  rebuild = "darwin-rebuild switch --flake $HOME/.config/nix/darwin#claire";
  kapply = "devbox run kapply";
  kdiff = "devbox run kdiff";
  hammerconfig = "code $HOME/.hammerspoon";
}
