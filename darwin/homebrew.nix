{ hostname, ... }:
let
  casks = [
    "amethyst"
    "appcleaner"
    "balenaetcher"
    "beekeeper-studio"
    "bitwarden"
    "cursor"
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
    "obsidian"
    "postman"
    "qbittorrent"
    "slack"
    "spotify"
    "trezor-suite"
    "vlc"
    "zoom"
  ];
  brews = [
    "k9s"
    "kind"
    "mkcert"
    "nvm"
    "ollama"
    "talosctl"
    "uv"
    "yq"
  ];
  extraCasks = builtins.toString ../darwin + "/${hostname}/extra-casks.nix";
  mergedCasks = casks ++ import extraCasks;
  extraBrew = builtins.toString ../darwin + "/${hostname}/extra-brews.nix";
  mergedBrews = brews ++ import extraBrew;
in {
  enable = true;
  brews = mergedBrews;
  casks = mergedCasks;
  global = { autoUpdate = true; };
  onActivation = {
    autoUpdate = true;
    upgrade = true;
    cleanup = "zap";
  };
}
