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
    "handbrake" # cli version
    "irssi"
    # "libheif" # gst
    # "libraw" # gst
    # "librsvg" # gst
    # "autoconf" 
    # "automake" 
    # "bazel"
    # "bison" 
    # "flex" 
    "gcc" 
    # "json-c"
    # "check"
    # "libtool"
    # "libyaml" # gst
    # "libsoup" # gst
    # "luarocks"
    # "meson" # gst
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
    cleanup = "uninstall";
  };
}
