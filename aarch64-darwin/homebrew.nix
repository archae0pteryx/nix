{
  enable = true;
  brews = [
    "luarocks"
  ];
  casks = [ "alacritty" "firefox" "copyq" "beekeeper-studio" "megasync"];
  onActivation = {
    autoUpdate = true;
    cleanup = "uninstall";
  };
}
 