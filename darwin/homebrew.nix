{ hostname, ... }:
let
  casks = [
    # "aerospace"
    "alacritty"
    "amethyst"
    "appcleaner"
    "audacity"
    "balenaetcher"
    "beekeeper-studio"
    "bitwarden"
    "blender"
    "comfyui"
    "cursor"
    "discord"
    "drawio"
    "firefox"
    "github"
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
    "telegram"
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
    "luarocks"
    "lynx"
    "mkcert"
    "redis"
    "podman"
    "rustup"
    "talosctl"
  ];
  casks = mergedCasks;
  global = { autoUpdate = true; };
  onActivation = {
    autoUpdate = true;
    upgrade = true;
    cleanup = "zap";
  };
}
