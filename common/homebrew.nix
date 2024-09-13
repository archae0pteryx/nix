{
    enable = true;
    brews = [
 
    ];
    casks = [
    "alacritty"
    "resilio-sync"
    ];
    onActivation = {
        autoUpdate = true;
        cleanup = "uninstall";
    };
}