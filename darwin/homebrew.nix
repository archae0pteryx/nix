{ hostname, ... }:
let
  casks = [
    "alacritty"
    "amethyst"
    "appcleaner"
    # "arc"
    "audacity"
    "balenaetcher"
    "beekeeper-studio"
    "bitwarden"
    "copyq"
    "comfyui"
    "cursor"
    "discord"
    "drawio"
    "firefox"
    "github"
    "godot"
    # "grandperspective"
    "keepassxc"
    "kitty"
    # "lm-studio"
    "logseq"
    "megasync"
    # "msty"
    "obsidian"
    "openlens"
    "postman"
    "qbittorrent"
    "slack"
    "spotify"
    "telegram"
    "trezor-suite"
    "visual-studio-code"
    "vivaldi"
    "vlc"
    "zoom"
    "aerospace"
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
    "redis"
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
