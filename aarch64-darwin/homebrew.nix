{
  enable = true;
  brews = [ "cairo" "pkg-config" "luarocks" ];
  casks = [
    "alacritty"
    "firefox"
    "copyq"
    "beekeeper-studio"
    "megasync"
    "mullvadvpn"
    "transmission"
    "mac-mouse-fix"
    "amethyst"
    "anythingllm"

  ];
  onActivation = {
    autoUpdate = true;
    cleanup = "uninstall";
  };
}
