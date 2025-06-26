{ hostname, ... }:
let
  casks = [
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
    # "discord"
    "figma"
    "firefox"
    "github"
    "gimp"
    "iterm2"
    "keepassxc"
    "logseq"
    "megasync"
    "miniconda"
    "obsidian"
    "openlens"
    "postman"
    "qbittorrent"
    "slack"
    "spotify"
    # "telegram"
    "trezor-suite"
    "visual-studio-code"
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
    # "handbrake" # cli version
    # "luarocks"
    "k6"
    "k9s"
    "mkcert"
    "nvm"
    "redis"
    # "podman"
    "rustup"
    "talosctl"
    "yq"
  ];
  casks = mergedCasks;
  global = { autoUpdate = true; };
  onActivation = {
    autoUpdate = true;
    upgrade = true;
    cleanup = "zap";
  };
}
