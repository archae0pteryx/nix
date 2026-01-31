{ pkgs }: [
  # Browser & Apps
  pkgs.firefox
  pkgs.vscodium
  pkgs.keepassxc

  # Shell & Terminal
  pkgs.tmux
  pkgs.neovim
  pkgs.fzf

  # Build Essentials
  pkgs.gcc
  pkgs.gnumake
  pkgs.cmake
  pkgs.pkg-config
  pkgs.autoconf
  pkgs.automake
  pkgs.libtool
  pkgs.binutils

  # Languages & Runtimes
  pkgs.go
  pkgs.rustup
  pkgs.bun
  pkgs.nodejs
  pkgs.uv

  # Network Tools
  pkgs.curl
  pkgs.wget
  pkgs.nmap
  pkgs.netcat-gnu
  pkgs.net-tools
  pkgs.dnsutils
  pkgs.traceroute
  pkgs.whois

  # Git & Dev Tools
  pkgs.git
  pkgs.gh
  pkgs.delta
  pkgs.ripgrep
  pkgs.jq
  pkgs.htop
  pkgs.unzip
  pkgs.zip

  # XFCE extras
  pkgs.xfce4-clipman-plugin
  pkgs.wmctrl

  # Fonts
  pkgs.nerd-fonts.fira-code
]
