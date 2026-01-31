#!/usr/bin/env bash

set -euo pipefail

GITHUB_USER=archae0pteryx
GITHUB_EMAIL=github@pocketcereal.com
NIX_REPO="https://github.com/archae0pteryx/nix"
NIX_CONFIG_DIR="$HOME/.config/nix"

log() {
    echo "[INFO] $*" >&2
}

error() {
    echo "[ERROR] $*" >&2
    exit 1
}

ensure_sudo() {
    if [[ $EUID -eq 0 ]]; then
        return 0
    fi

    if ! command -v sudo &> /dev/null; then
        error "sudo is not installed. Please install sudo or run as root."
    fi

    if ! sudo -v; then
        error "sudo authentication failed."
    fi

    # Keep sudo alive
    while true; do
        sudo -n true
        sleep 60
        kill -0 "$$" || exit
    done &
}

install_homebrew() {
    if ! command -v brew &>/dev/null; then
        log "Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
}

install_nix() {
    if ! command -v nix &>/dev/null; then
        log "Installing Nix..."
        sh <(curl -L https://nixos.org/nix/install)
    fi
}

setup_ssh_key() {
    if [ ! -f ~/.ssh/id_ed25519 ]; then
        log "Generating SSH key..."
        ssh-keygen -t ed25519 -f "$HOME/.ssh/id_ed25519" -N "" -q
        log "Add this key to GitHub: $(cat ~/.ssh/id_ed25519.pub)"
    fi
}

setup_git_config() {
    if ! git config --global --get user.name &>/dev/null; then
        log "Configuring git..."
        git config --global user.name "$GITHUB_USER"
        git config --global user.email "$GITHUB_EMAIL"
    fi
}

clone_nix_repo() {
    if [ ! -d "$NIX_CONFIG_DIR" ]; then
        log "Cloning nix config repo..."
        git clone "$NIX_REPO" "$NIX_CONFIG_DIR"
    fi
}

setup_nix_darwin() {
    local hostname
    hostname=$(scutil --get LocalHostName)

    log "Setting up nix-darwin for $hostname..."
    cd "$NIX_CONFIG_DIR"
    nix run nix-darwin -- switch --flake "./darwin#$hostname"
}

main() {
    command -v git >/dev/null 2>&1 || error "git is not installed"
    command -v curl >/dev/null 2>&1 || error "curl is not installed"

    log "Bootstrapping..."
    ensure_sudo

    install_homebrew
    install_nix
    setup_ssh_key
    setup_git_config
    clone_nix_repo
    setup_nix_darwin

    log "Done! Run 'task rebuild:<hostname>' to rebuild."
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi
