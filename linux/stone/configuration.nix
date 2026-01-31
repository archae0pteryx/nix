{ config, pkgs, lib, ... }:

let
  hostname = "stone";
  username = "nix";
in {
  imports = [
    ./hardware-configuration.nix
    ./zsh.nix
  ];

  # Bootloader (GRUB)
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Networking
  networking.hostName = hostname;
  networking.networkmanager.enable = true;
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 22 ];
    allowPing = false;
  };

  # Locale/Time
  time.timeZone = "America/Los_Angeles";
  i18n.defaultLocale = "en_US.UTF-8";

  # X11 + XFCE
  services.xserver = {
    enable = true;
    displayManager.lightdm.enable = true;
    desktopManager.xfce.enable = true;
    xkb.layout = "us";
  };

  # Audio
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };

  # Services
  services.printing.enable = true;
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      PermitRootLogin = "no";
    };
  };
  services.gnome.gnome-keyring.enable = true;
  security.pam.services.lightdm.enableGnomeKeyring = true;

  # Docker
  virtualisation.docker.enable = true;

  # Programs
  programs.xfconf.enable = true;
  programs.firefox.enable = true;
  programs.git.enable = true;

  # User
  users.users.${username} = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    openssh.authorizedKeys.keyFiles = [
      ./keys/stone.pub
      ../../common/ssh/eyepop.local.pub
      ../../common/ssh/claire.local.pub
    ];
  };

  # Packages
  environment.systemPackages = with pkgs; [
    # Shell/Terminal
    vim neovim tmux fzf

    # Dev tools
    git gh curl wget ripgrep jq htop unzip zip

    # Build essentials
    gcc gnumake cmake pkg-config

    # Languages
    go rustup nodejs bun

    # Network
    nmap netcat-gnu net-tools dnsutils

    # Apps
    vscodium keepassxc

    # XFCE
    xfce4-clipman-plugin wmctrl

    # Clipboard (for vim integration)
    xclip xsel

    # Keyring
    gcr seahorse
  ];

  # User config files (vimrc, xfce shortcuts)
  system.activationScripts.userConfigs = let
    vimrc = ./vimrc;
    xfceShortcuts = ./xfce4-keyboard-shortcuts.xml;
  in ''
    # Deploy vimrc
    install -D -m 644 -o ${username} -g users ${vimrc} /home/${username}/.vimrc

    # Deploy neovim config
    mkdir -p /home/${username}/.config/nvim
    install -m 644 -o ${username} -g users ${vimrc} /home/${username}/.config/nvim/init.vim

    # Deploy XFCE keyboard shortcuts
    mkdir -p /home/${username}/.config/xfce4/xfconf/xfce-perchannel-xml
    install -m 644 -o ${username} -g users ${xfceShortcuts} /home/${username}/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-keyboard-shortcuts.xml
    chown -R ${username}:users /home/${username}/.config
  '';

  # Nix
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "25.11";
}
