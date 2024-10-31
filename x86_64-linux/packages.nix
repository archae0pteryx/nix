{ pkgs }: 
let
  google-cloud-sdk = pkgs.google-cloud-sdk.withExtraComponents [pkgs.google-cloud-sdk.components.gke-gcloud-auth-plugin];
in [
    google-cloud-sdk
    pkgs.alacritty
    pkgs.awscli
    pkgs.beekeeper-studio
    pkgs.bitwarden-cli
    pkgs.brave
    pkgs.cachix
    pkgs.cmake
    pkgs.delta
    pkgs.devbox
    pkgs.discord
    pkgs.dmenu
    pkgs.dnsutils
    pkgs.edid-decode
    pkgs.emojipick
    pkgs.fd
    pkgs.ffmpeg
    pkgs.fishPlugins.fzf-fish
    pkgs.fishPlugins.z
    pkgs.font-manager
    pkgs.fzf
    pkgs.gcc
    pkgs.gdb
    pkgs.gnome-calculator
    pkgs.gnumake
    pkgs.hunspell
    pkgs.jq
    pkgs.k9s
    pkgs.keepassxc
    pkgs.kubectl
    pkgs.kubectl
    pkgs.kubectx
    pkgs.kubectx
    pkgs.kubernetes-helm
    pkgs.libreoffice
    pkgs.logseq
    pkgs.meld
    pkgs.mullvad-vpn
    pkgs.nixfmt-classic
    pkgs.nmap
    pkgs.obsidian
    pkgs.openlens
    pkgs.openssl
    pkgs.opentofu
    pkgs.pamixer
    pkgs.pipx
    pkgs.pkg-config
    pkgs.playerctl
    pkgs.postman
    pkgs.python311
    pkgs.remmina
    pkgs.ripgrep
    pkgs.ripgrep
    pkgs.slack
    pkgs.speedtest-cli
    pkgs.spotify
    pkgs.sshfs
    pkgs.starship
    pkgs.stern
    pkgs.tdrop
    pkgs.teller
    pkgs.terraform
    pkgs.terragrunt
    pkgs.thunderbird
    pkgs.tmux
    pkgs.traceroute
    pkgs.unzip
    pkgs.usbutils
    pkgs.vlc
    pkgs.vscode
    pkgs.xclip
    pkgs.xfce.xfce4-panel
    pkgs.xfce.xfce4-pulseaudio-plugin
    pkgs.xorg.xmodmap
    pkgs.xsel
    pkgs.zip
    (pkgs.nerdfonts.override { fonts = [ "FiraCode" ]; })
  ]