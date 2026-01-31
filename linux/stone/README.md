# Stone - Minimal Secure NixOS Workstation

Standalone NixOS flake with home-manager integration.

## Overview

- **Hostname**: stone
- **Username**: nix
- **Desktop**: XFCE
- **Purpose**: Secure, isolated workstation

## Setup

### 1. Copy hardware configuration

On the stone machine:

```bash
cp /etc/nixos/hardware-configuration.nix ~/.config/nix/linux/stone/
```

### 2. Generate SSH keys

```bash
ssh-keygen -t ed25519 -f ~/.ssh/id_ed25519
ssh-keygen -t ed25519 -f ~/.ssh/signing_ed25519 -C "git-signing"
```

### 3. Add signing key to GitHub

Settings > SSH and GPG keys > New SSH key (type: Signing Key)

### 4. Rebuild

From the repo root:

```bash
task rebuild:stone
```

Or manually:

```bash
sudo nixos-rebuild switch --flake ~/.config/nix/linux/stone#stone
```

## Security

- **Firewall**: Inbound SSH only, no ping
- **SSH**: Key-only auth, no root login

## Keyboard Shortcuts

| Shortcut | Action |
|----------|--------|
| `Alt+1..4` | Switch to workspace |
| `Alt+Shift+1..4` | Move window to workspace |
| `Ctrl+Shift+V` | Clipboard history |
