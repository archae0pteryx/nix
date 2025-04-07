{ hostname, ... }:
let
  casks = [
    "alacritty"
    "amethyst"
    "appcleaner"
    "arc"
    "audacity"
    "balenaetcher"
    "beekeeper-studio"
    "bitwarden"
    "copyq"
    "cursor"
    "discord"
    "firefox"
    "grandperspective"
    "github"
    "kitty"
    "keepassxc"
    "logseq"
    "megasync"
    "obsidian"
    "openlens"
    "postman"
    "slack"
    "spotify"
    "trezor-suite"
    "qbittorrent"
    "vivaldi"
    "visual-studio-code"
    "vlc"
    "zoom"
  ];
  extraCasks = builtins.toString ../darwin + "/${hostname}/extra-casks.nix";
  mergedCasks = casks ++ import extraCasks;
in {
  enable = true;
  brews = [
    # # "adwaita-icon-theme"
    # "gtk4"
    "handbrake" # cli version
    # "irssi"
    "libffi"
    # "libheif" # gst
    # "libraw" # gst
    # "librsvg" # gst
    # "autoconf" 
    # "automake" 
    # "bazel"
    # "bison" 
    # "flex"
    "docker-slim"
    "gcc" 
    "lynx"
    # "json-c"
    # "check"
    # "libtool"
    # "libyaml" # gst
    # "libsoup" # gst
    # "luarocks"
    # "meson" # gst
    # "tailscale"
    "mkcert"
     # "ninja"
    # "lmdb" # gst
    # "opencv"
    # "pcre" # gst
    "podman"
    "rustup"
    # "talloc"  # gst
    "talosctl"
    "xsel"
  ];
  casks = mergedCasks;
  global = { autoUpdate = true; };
  onActivation = {
    autoUpdate = true;
    upgrade = true;
    cleanup = "zap";
  };
}
