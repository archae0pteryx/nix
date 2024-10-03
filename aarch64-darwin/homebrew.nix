{
  enable = true;
  brews = [ "luarocks" ];
  casks = [
    "amethyst"
    "anythingllm"
    "beekeeper-studio"
    "copyq"
    "firefox"
    "megasync"
    "mullvadvpn"
    "transmission"
  ];
  onActivation = {
    autoUpdate = true;
    cleanup = "uninstall";
  };
}
