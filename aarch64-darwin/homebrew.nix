{
  enable = true;
  brews = [ "luarocks" ];
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
