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
  ];
  onActivation = {
    autoUpdate = true;
    cleanup = "uninstall";
  };
}
