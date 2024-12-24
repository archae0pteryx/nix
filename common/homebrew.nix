{ hostname, ... }:
let
  casks = [
    "amethyst"
    "audacity"
    "cursor"
    "discord"
    "logseq"
    "appcleaner"
    "backblaze"
    "balenaetcher"
    "beekeeper-studio"
    "copyq"
    "dupeguru"
    "figma"
    "firefox"
    "headlamp"
    "kitty"
    "megasync"
    "mullvadvpn"
    "openlens"
    "postman"
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
    "libheif"
    "handbrake" # cli version
    "libraw"
    "librsvg"
    "luarocks"
    "rustup"
    "xsel"
  ];
  casks = mergedCasks;
  global = { autoUpdate = true; };
  onActivation = {
    autoUpdate = true;
    upgrade = true;
    cleanup = "uninstall";
  };
}
