{
  enable = true;
  brews = [

  ];
  casks = [ "alacritty" "firefox" "copyq" "beekeeper-studio" ];
  onActivation = {
    autoUpdate = true;
    cleanup = "uninstall";
  };
}
