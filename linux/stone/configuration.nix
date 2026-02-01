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
    allowedUDPPorts = [ 41641 ];  # Tailscale
    allowPing = false;
    trustedInterfaces = [ "tailscale0" ];  # Trust Tailscale interface
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
  services.tailscale.enable = true;

  # Tailscale exit node optimizer - checks and switches to best Mullvad exit node
  systemd.services.tailscale-exit-node-check = {
    description = "Check and update Tailscale exit node";
    after = [ "network-online.target" "tailscaled.service" ];
    wants = [ "network-online.target" ];
    path = [ pkgs.tailscale pkgs.jq pkgs.gnugrep ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.bash}/bin/bash ${./scripts/tailscale-exit-node-check.sh}";
    };
  };

  systemd.timers.tailscale-exit-node-check = {
    description = "Run Tailscale exit node check every 30 minutes";
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnBootSec = "5min";
      OnUnitActiveSec = "30min";
      RandomizedDelaySec = "5min";
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

  # Enable nix-ld for dynamically linked executables (npm, etc.)
  programs.nix-ld.enable = true;

  # direnv for automatic .env/.envrc loading
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;  # Better nix integration
  };

  # User
  users.users.${username} = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    openssh.authorizedKeys.keyFiles = [
      ../../common/ssh/eyepop.local.pub
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

    # Dev environments
    devbox

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

  # User config files (vimrc, tmux, xfce shortcuts)
  system.activationScripts.userConfigs = let
    vimrc = ./vimrc;
    tmuxConf = ../../common/tmux.conf;
    xfceShortcuts = ./xfce4-keyboard-shortcuts.xml;
  in ''
    # Deploy vimrc
    install -D -m 644 -o ${username} -g users ${vimrc} /home/${username}/.vimrc

    # Deploy neovim config
    mkdir -p /home/${username}/.config/nvim
    install -m 644 -o ${username} -g users ${vimrc} /home/${username}/.config/nvim/init.vim

    # Deploy tmux config
    install -m 644 -o ${username} -g users ${tmuxConf} /home/${username}/.tmux.conf

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
