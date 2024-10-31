{
  enable = true;
  brews = [
    "cairo"
    "giflib"
    "icu4c"
    "jpeg"
    "libpng"
    "librsvg"
    "luarocks"
    "pango"
    "pkg-config"
  ];
  casks = [
    "amethyst"
    "anythingllm"
    "balenaetcher"
    "beekeeper-studio"
    "copyq"
    "figma"
    "firefox"
    "megasync"
    "monokle"
    "mullvadvpn"
    "openlens"
    "transmission"
    "unetbootin"
  ];
  onActivation = {
    autoUpdate = true;
    cleanup = "uninstall";
  };
}
