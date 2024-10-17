{
  enable = true;
  brews = [ "luarocks" "cairo"];
  casks = [
    "amethyst"
    "anythingllm"
    "beekeeper-studio"
    "copyq"
    "firefox"
    "megasync"
    "monokle"
    "mullvadvpn"
    "openlens"
    "transmission"
  ];
  onActivation = {
    autoUpdate = true;
    cleanup = "uninstall";
  };
}
