{ hostname, ... }:
let
  casks = [
    "amethyst"
    "appcleaner"
    "audacity"
    "backblaze"
    "balenaetcher"
    "beekeeper-studio"
    "copyq"
    "cursor"
    "discord"
    "dupeguru"
    "figma"
    "firefox"
    "headlamp"
    "kitty"
    "logseq"
    "megasync"
    "mullvadvpn"
    "obsidian"
    "openlens"
    "postman"
    "unetbootin"
    "visual-studio-code"
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
