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
    "backblaze"
  ];
  onActivation = {
    autoUpdate = true;
    cleanup = "uninstall";
  };
}
