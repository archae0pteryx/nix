{ hostname, ... }:
let
  casks = [
    # "aerospace"
    "amethyst"
    "alacritty"
    # "amethyst"
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
    "grandperspective"
    "iterm2"
    "keepassxc"
    "logseq"
    "megasync"
    "meld"
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
    "void"
    "zoom"
  ];
  extraCasks = builtins.toString ../darwin + "/${hostname}/extra-casks.nix";
  mergedCasks = casks ++ import extraCasks;
in {
  enable = true;
  taps = ["nikitabobko/aerospace"];
  brews = [
    "difftastic"
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
