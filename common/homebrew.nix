{
  enable = true;
  brews = [

  ];
  casks = [ "alacritty" "firefox" "copyq"  ];
  onActivation = {
    autoUpdate = true;
    cleanup = "uninstall";
  };
}
