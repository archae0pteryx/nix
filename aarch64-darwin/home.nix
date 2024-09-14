{ pkgs, ... }:
let
  google-cloud-sdk = pkgs.google-cloud-sdk.withExtraComponents [pkgs.google-cloud-sdk.components.gke-gcloud-auth-plugin];
  commonFish = import ../common/fish {  };
  macFishAliases = import ./aliases.nix {};
  mergedFish = lib.recursiveUpdate commonFish macFishAliases;
in
{
  home.stateVersion = "24.11";
  programs.home-manager.enable = true;
  programs.vscode.enable = true;
  programs.vscode.extensions = [ pkgs.vscode-extensions.bbenoist.nix ];
  programs.fish = mergedFish;

  programs.starship.enable = true;
  home.file = { ".vimrc".source = ../common/vimrc; };
  home.file = { ".tmux.conf".source = ../common/tmux.conf; };
  xdg.configFile."starship.toml".text = builtins.readFile ../common/starship.toml;
  home.sessionVariables = { EDITOR = "vim"; };
  home.packages = [
    (pkgs.nerdfonts.override { fonts = [ "FiraCode" ]; })
    google-cloud-sdk
    pkgs.devbox
    pkgs.discord
    pkgs.fzf
    pkgs.keepassxc
    pkgs.logseq
    pkgs.nixfmt-classic
    pkgs.obsidian
    pkgs.pipx
    pkgs.postman
    pkgs.python311
    pkgs.slack
    pkgs.spotify
    pkgs.kitty
    # pkgs.alacritty
    # pkgs.beekeeper-studio
    # pkgs.bitwarden-cli
    # pkgs.brave
    # pkgs.cmake
    # pkgs.dmenu
    # pkgs.dnsutils
    # pkgs.emojipick
    # pkgs.fd
    # pkgs.ffmpeg
    # pkgs.fishPlugins.fzf-fish
    # pkgs.fishPlugins.z
    # pkgs.font-manager
    # pkgs.gcc
    # pkgs.gdb
    # pkgs.gh
    # pkgs.gnome-calculator
    # pkgs.gnumake
    # pkgs.hunspell
    # pkgs.jq
    # pkgs.k9s
    # pkgs.kubectl
    # pkgs.kubectl
    # pkgs.kubectx
    # pkgs.kubectx
    # pkgs.kubernetes-helm
    # pkgs.libreoffice
    # pkgs.mullvad-vpn
    # pkgs.nmap
    # pkgs.openlens
    # pkgs.openssl
    # pkgs.opentofu
    # pkgs.pamixer
    # pkgs.playerctl
    # pkgs.ripgrep
    # pkgs.ripgrep
    # pkgs.speedtest-cli
    # pkgs.stern
    # pkgs.tdrop
    # pkgs.teller
    # pkgs.terraform
    # pkgs.terragrunt
    # pkgs.tmux
    # pkgs.traceroute
    # pkgs.unzip
    # pkgs.usbutils
    # pkgs.xclip
    # pkgs.xfce.xfce4-panel
    # pkgs.xfce.xfce4-pulseaudio-plugin
    # pkgs.xorg.xmodmap
    # pkgs.xsel
    # pkgs.zip
  ];
  programs.git = import ../common/git.nix;
  programs.gh = {
    enable = true;
    gitCredentialHelper.enable = true;
  };
  programs.gpg.enable = true;
  programs.ssh = {
    enable = true;
    forwardAgent = true;
  };
 }
