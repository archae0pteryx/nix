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
    "drawio"
    "dupeguru"
    "figma"
    "firefox"
    "kitty"
    "logseq"
    "megasync"
    "mullvadvpn"
    "obsidian"
    "openlens"
    "postman"
    "trezor-suite"
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
    "mkcert"
    "podman"
    "rustup"
    "xsel"
    "irssi"
    "talosctl"
  ];
  casks = mergedCasks;
  global = { autoUpdate = true; };
  onActivation = {
    autoUpdate = true;
    upgrade = true;
    cleanup = "uninstall";
  };
}
