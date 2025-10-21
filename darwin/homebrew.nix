{ hostname, ... }:
let
  casks = [
    "amethyst"
    "appcleaner"
    "balenaetcher"
    # "beekeeper-studio"
    "bitwarden"
    "blackhole-2ch"
    # "blender"
    # "comfyui"
    "cursor"
    "figma"
    "firefox"
    "github"
    "gimp"
    "google-chrome"
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
    # "mkcert"
    "colima"
    "nvm"
    "ollama"
    "opentofu"
    "terragrunt"
    "talosctl"
    "uv"
    "yq"
    "qemu"
    # tap

  ];
  extraCasks = builtins.toString ../darwin + "/${hostname}/extra-casks.nix";
  mergedCasks = casks ++ import extraCasks;
  extraBrew = builtins.toString ../darwin + "/${hostname}/extra-brews.nix";
  mergedBrews = brews ++ import extraBrew;
in {
  enable = true;
  taps = [
    "facebook/fb"
    "mobile-dev-inc/tap"
  ];
  brews = mergedBrews;
  casks = mergedCasks;
  global = { autoUpdate = true; };
  onActivation = {
    autoUpdate = true;
    upgrade = true;
    cleanup = "uninstall";
  };
}
