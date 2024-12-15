{ hostname, ... }:
let
  casks = [
    "amethyst"
    "anythingllm"
    "aptakube"
    "backblaze"
    "balenaetcher"
    "beekeeper-studio"
    "brave-browser"
    "copyq"
    "dupeguru"
    "figma"
    "firefox"
    "headlamp"
    "mediaelch"
    "megasync"
    "mullvadvpn"
    "openlens"
    "postman"
    "transmission"
    "unetbootin"
    "vlc"
    "visual-studio-code"
  ];
  extraCasks = builtins.toString ../darwin + "/${hostname}/extra-casks.nix";
  mergedCasks = casks ++ import extraCasks;
in {
  enable = true;
  brews = [
    "adwaita-icon-theme"
    "gtk4"
    "handbrake"
    "libheif"
    "libraw"
    "librsvg"
    "luarocks"
    "rustup"
  ];
  casks = mergedCasks;
  global = { autoUpdate = true; };
  onActivation = {
    autoUpdate = true;
    upgrade = true;
    cleanup = "uninstall";
  };
}
