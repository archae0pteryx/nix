{ hostname, ... }:
let
  casks = [
    "alacritty"
    "amethyst"
    "appcleaner"
    "arc"
    "audacity"
    "balenaetcher"
    "beekeeper-studio"
    "bitwarden"
    "copyq"
    "cursor"
    "discord"
    "firefox"
    "github"
    "grandperspective"
    "keepassxc"
    "kitty"
    "logseq"
    "megasync"
    "obsidian"
    "openlens"
    "postman"
    "qbittorrent"
    "slack"
    "spotify"
    "trezor-suite"
    "visual-studio-code"
    "vivaldi"
    "vlc"
    "zoom"
  ];
  extraCasks = builtins.toString ../darwin + "/${hostname}/extra-casks.nix";
  mergedCasks = casks ++ import extraCasks;
in {
  enable = true;
  brews = [
    "docker-slim"
    "gcc" 
    "handbrake" # cli version
    "libffi"
    "lynx"
    "mkcert"
    "podman"
    "rustup"
    "talosctl"
    "xsel"
  ];
  casks = mergedCasks;
  global = { autoUpdate = true; };
  onActivation = {
    autoUpdate = true;
    upgrade = true;
    cleanup = "zap";
  };
}
