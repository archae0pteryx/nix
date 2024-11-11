{
  enable = true;
  brews = [
    "cairo"
    "giflib"
    "icu4c"
    "jpeg"
    "libmagic"
    "libpng"
    "librsvg"
    "luarocks"
    "pango"
    "pkg-config"
  ];
  casks = [
    "amethyst"
    "anythingllm"
    "aptakube"
    "backblaze"
    "balenaetcher"
    "beekeeper-studio"
    "copyq"
    "figma"
    "firefox"
    "headlamp"
    "megasync"
    "monokle"
    "mullvadvpn"
    "openlens"
    "transmission"
    "unetbootin"
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
