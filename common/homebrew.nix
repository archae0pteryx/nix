{
  enable = true;
  brews = [
    "adwaita-icon-theme"
    "gtk4"
    "gtk-vnc"
    "libheif"
    "libraw"
    "librsvg"
    "luarocks"
    "rustup"
  ];
  casks = [
    # "alfred"
    "amethyst"
    "anythingllm"
    "aptakube"
    "backblaze"
    "balenaetcher"
    "beekeeper-studio"
    "copyq"
    "figma"
    "firefox"
    # "hammerspoon"
    "headlamp"
    "mediaelch"
    "megasync"
    "mullvadvpn"
    "openlens"
    "postman"
    "transmission"
    "unetbootin"
    "visual-studio-code"
  ];
  global = { autoUpdate = true; };
  onActivation = {
    autoUpdate = true;
    upgrade = true;
    cleanup = "uninstall";
  };
}
