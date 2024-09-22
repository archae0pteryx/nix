{
  enable = true;
  brews = [
    "luarocks"
  ];
  casks = [ "alacritty" "firefox" "copyq" "beekeeper-studio" "megasync" "mullvadvpn" ];
  onActivation = {
    autoUpdate = true;
    cleanup = "uninstall";
  };
}
 