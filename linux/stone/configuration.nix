{ pkgs, hostname, username, ... }: {
  imports = [ ./hardware-configuration.nix ];

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Networking
  networking.hostName = hostname;
  networking.networkmanager.enable = true;

  # Firewall - locked down inbound
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 22 ];
    allowedUDPPorts = [ ];
    allowPing = false;
    logRefusedConnections = true;
  };

  # Locale/Time
  time.timeZone = "America/Los_Angeles";
  i18n.defaultLocale = "en_US.UTF-8";

  # X11 + XFCE
  services.xserver = {
    enable = true;
    desktopManager.xfce.enable = true;
    desktopManager.xterm.enable = false;
  };
  services.displayManager.defaultSession = "xfce";

  # Enable xfconf for saving XFCE preferences
  programs.xfconf.enable = true;

  # User
  users.users.${username} = {
    isNormalUser = true;
    description = "nix";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.zsh;
    openssh.authorizedKeys.keyFiles = [
      ./keys/stone.pub
      ../../common/ssh/eyepop.local.pub
      ../../common/ssh/claire.local.pub
    ];
  };

  # ZSH system-wide
  programs.zsh.enable = true;
  environment.pathsToLink = [ "/share/zsh" ];

  # SSH server (hardened)
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      PermitRootLogin = "no";
      KbdInteractiveAuthentication = false;
    };
  };

  # Nix settings
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    trusted-users = [ "root" username ];
  };

  nixpkgs.config.allowUnfree = true;

  # Minimal system packages
  environment.systemPackages = with pkgs; [ vim git curl wget ];

  system.stateVersion = "24.11";
}
