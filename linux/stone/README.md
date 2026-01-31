# Stone - Minimal Secure NixOS Workstation

A standalone NixOS flake for the `stone` machine with home-manager integration.

## Overview

- **Hostname**: stone
- **Username**: nix
- **Desktop**: XFCE
- **Purpose**: Secure, isolated workstation with minimal attack surface

## Setup Instructions

### 1. Copy hardware configuration

From the stone machine, copy the existing hardware config:

```bash
cp /etc/nixos/hardware-configuration.nix /path/to/this/dir/
```

### 2. Generate SSH keys

```bash
# Authentication key
ssh-keygen -t ed25519 -f ~/.ssh/id_ed25519

# Git signing key
ssh-keygen -t ed25519 -f ~/.ssh/signing_ed25519 -C "git-signing"
```

### 3. Add public key to this repo

Copy the auth public key to allow SSH access from other machines:

```bash
cp ~/.ssh/id_ed25519.pub /path/to/repo/linux/stone/keys/stone.pub
```

### 4. Add signing key to GitHub

1. Copy contents of `~/.ssh/signing_ed25519.pub`
2. Go to GitHub > Settings > SSH and GPG keys
3. Click "New SSH key"
4. Select "Signing Key" as the key type
5. Paste and save

### 5. Rebuild

```bash
sudo nixos-rebuild switch --flake .#stone
```

## Security

- **Firewall**: Inbound SSH only, no ping
- **SSH**: Key-only auth, no root login, no password auth
- **Outbound**: Unrestricted (required for nix, git, package managers)

## Keyboard Shortcuts

| Shortcut | Action |
|----------|--------|
| `Alt+1..4` | Switch to workspace 1-4 |
| `Alt+Shift+1..4` | Move window to workspace 1-4 |
| `Ctrl+Shift+V` | Clipboard history (Clipman) |

## Installed Tools

- **Browser**: Firefox
- **Editor**: VSCodium, Neovim
- **Languages**: Go, Rust (rustup), Node.js, Bun, Python (uv)
- **Build**: gcc, make, cmake, pkg-config, autoconf
- **Network**: nmap, netcat, net-tools, dnsutils, traceroute
- **Shell**: Zsh with antidote, z plugin, syntax highlighting
