{ hostname, ... }:
let
  casks = [
    "amethyst"
    "alfred"
#    "appcleaner"
#    "balenaetcher"
#    "beekeeper-studio"
    "bitwarden"
    "brave-browser"
#   "blackhole-2ch"
#   "blender"
#   "comfyui"
    "claude"
    "cursor"
    "figma"
    "firefox"
    "github"
    "gimp"
    "google-chrome"
#   "grandperspective"
    "iterm2"
    "keepassxc"
#    "logseq"
    "megasync"
    "meld"
    "obsidian"
    "postman"
    "qbittorrent"
    "slack"
    "spotify"
    "tailscale-app"
    "trezor-suite"
    "vlc"
    "zoom"
  ];
  brews = [
    "bun"
    "k9s"
    "kind"
    # "mkcert"
    "colima"
    "nvm"
    #"ollama"
    "stow"
    "terragrunt"
    "talosctl"
    "uv"
    "yq"
    #"qemu"
  ];
  extraCasks = ./${hostname}/extra-casks.nix;
  mergedCasks = casks ++ import extraCasks;
  extraBrew = ./${hostname}/extra-brews.nix;
  mergedBrews = brews ++ import extraBrew;
in {
  enable = true;
  taps = [
    "oven-sh/bun"
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
