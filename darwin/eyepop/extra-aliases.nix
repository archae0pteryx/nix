{
  rebuild = "darwin-rebuild switch --flake $HOME/.config/nix/darwin#eyepop";
  nixcheck = "darwin-rebuild build --flake $HOME/.config/nix/darwin#eyepop";
  hammerconfig = "cursor $HOME/.hammerspoon";
  keepass = "keepassxc-cli";
}
