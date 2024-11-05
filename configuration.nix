# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];
  # added start
  hardware.nvidia = {
    package = config.boot.kernelPackage.nvidiaPackages.latest;
    modesetting.enable = true;
    powerManagement = true;
  };

  hardware.graphics = {
    enable = true;
    enable32Bit = true;

    extraPackages = with pkgs; [
      intel-media-driver
      vaapiIntel
      vaapiVdpau
      libvdpau-va-gl
    ];
  };
  # added end

  services.xserver = {
    enable = true;
    # added line
    videoDrivers = [ "nvidia" "intel" ]
    desktopManager = {
      xterm.enable = false;
      xfce = {
        enable = true;
        noDesktop = true;
        enableXfwm = false;
      };
    };
    windowManager.i3.enable = true;
    xkb = {
      layout = "us";
      variant = "";
    };
  };

  services.displayManager.defaultSession = "xfce+i3";

  # added line
  programs.cuda.enable = true;

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  nix = {
    settings.trusted-users = [ "root" "rimraf" "ryan" ];
    package = pkgs.nixVersions.latest;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  # networking.hostName = "nixos"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.
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


  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };

  users.users.rimraf = {
    shell = pkgs.zsh;
    isNormalUser = true;
    description = "rimraf";
    extraGroups =
      [ "video" "docker" "networkmanager" "wheel" "vault" "rslsync" ];
    packages = with pkgs; [ vim curl git ];
    openssh.authorizedKeys = {
      keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGnDgY/SCSGJUUrw3WChvADAeWTGHRDUvgjy+TmlrDG0 ryan@eyepop.local"
      ];
    };
  };
  users.groups.vault = { members = [ "rimraf" ]; };

  fonts = {
    fontconfig = { enable = true; };
    fontDir.enable = true;
    enableDefaultPackages = true;
  };

  programs.nm-applet.enable = true;
  programs.zsh.enable = true;
  programs.fish.enable = true;
  programs.firefox.enable = true;
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    vim
    wget
    git
    cachix
    sshfs
    pciutils
    cudatoolKit # added
    cudnn # added
  ];

  virtualisation = {
    docker = {
      enable = true;
      daemon.settings = {
        userland-proxy = false;
        experimental = true;
      };
      rootless = {
        enable = true;
        setSocketVariable = true;
      };
    };
  };
  system.copySystemConfiguration = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # List services that you want to enable:
  services.mullvad-vpn.enable = true;
  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    banner = ''
      Fuck off, shithead.
      		'';
    settings = {
      PasswordAuthentication = false;
      AllowUsers = [ "rimraf" ];
      X11Forwarding = true;
    };
  };
  services.gnome.gnome-browser-connector.enable = true;
  services.gnome.gnome-keyring.enable = true;
  security.pam.services.rimraf.gnupg.enable = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "24.11"; # Did you read the comment?

}

