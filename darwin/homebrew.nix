{ hostname, ... }:
let
  casks = [
    "alfred"
    "amethyst"
    "balenaetcher"
    "bitwarden"
    "brave-browser"
    "claude"
    "cursor"
    "figma"
    "firefox"
    "gimp"
    "github"
    "google-chrome"
    "iterm2"
    "keepassxc"
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
    "k9s"
    "kind"
    "colima"
    "nvm"
    "stow"
    "terragrunt"
    "talosctl"
    "uv"
    "yq"
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
