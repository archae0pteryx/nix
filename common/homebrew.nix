{ hostname, ... }:
let
  casks = [
    "amethyst"
    "anythingllm"
    "aptakube"
    "backblaze"
    "balenaetcher"
    "beekeeper-studio"
    "copyq"
    "dupeguru"
    "figma"
    "firefox"
    "headlamp"
    "megasync"
    "mullvadvpn"
    "openlens"
    "postman"
    "transmission"
    "unetbootin"
    "vlc"
  ];
  extraCasks = builtins.toString ../darwin + "/${hostname}/extra-casks.nix";
  mergedCasks = casks ++ import extraCasks;
in {
  enable = true;
  brews = [
    "adwaita-icon-theme"
    "gtk4"
    "libheif"
    "handbrake" # cli version
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
