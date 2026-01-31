{ pkgs, hostname, username, ... }: {
  imports = [ ./hardware-configuration.nix ];

  # Bootloader (GRUB for this machine)
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;

  # Use latest kernel
  boot.kernelPackages = pkgs.linuxPackages_latest;

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
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # X11 + XFCE
  services.xserver = {
    enable = true;
    displayManager.lightdm.enable = true;
    desktopManager.xfce.enable = true;
    desktopManager.xterm.enable = false;
    xkb = {
      layout = "us";
      variant = "";
    };
  };

  # Enable xfconf for saving XFCE preferences
  programs.xfconf.enable = true;

  # Audio (pipewire)
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Printing
  services.printing.enable = true;

  # GNOME Keyring (for VSCodium, credential storage)
  services.gnome.gnome-keyring.enable = true;
  security.pam.services.login.enableGnomeKeyring = true;
  security.pam.services.lightdm.enableGnomeKeyring = true;

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
  environment.systemPackages = with pkgs; [ vim git curl wget tmux ];

  system.stateVersion = "25.11";
}
