{
  enable = true;
  brews = [
    # "cairo"
    # "giflib"
    # "icu4c"
    # "jpeg"
    # "libmagic"
    # "libpng"
    # "librsvg"
    "luarocks"
    # "pango"
    # "pkg-config"
  ];
  casks = [
    "alfred"
    "amethyst"
    "anythingllm"
    "aptakube"
    "backblaze"
    "balenaetcher"
    "beekeeper-studio"
    "copyq"
    "figma"
    "firefox"
    "hammerspoon"
    "headlamp"
    "megasync"
    "mullvadvpn"
    "openlens"
    "postman"
    "transmission"
    "unetbootin"
    "visual-studio-code"
  ];
  global = {
    autoUpdate = true;
  };
  onActivation = {
    autoUpdate = true;
    upgrade = true;
    cleanup = "uninstall";
  };
}
