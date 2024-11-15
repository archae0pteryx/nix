#!/usr/bin/env bash

set -euo pipefail

THIS_USER=$(whoami)
HOSTNAME=$(scutil --get LocalHostName)
GITHUB_USER=archae0pteryx
GITHUB_EMAIL=github@pocketcereal.com

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

    while true; do
        sudo -n true
        sleep 60
        kill -0 "$$" || exit
    done &
}

git_config() {
    git config --global user.name "$GITHUB_USER"
    git config --global user.email "$GITHUB_EMAIL"
}

prompt_sudo() {
    local message="${1:-This script requires sudo privileges}"
    
    echo "$message" >&2
    ensure_sudo
}

setup_nix_darwin() {
    mkdir -p ~/.config/nix-darwin
    cd ~/.config/nix-darwin
    nix flake init -t nix-darwin
    sed -i '' "s/simple/$(scutil --get LocalHostName)/" flake.nix
    nix run nix-darwin -- switch --flake ~/.config/nix-darwin
    darwin-rebuild switch --flake ~/.config/nix-darwin
}

setup_nix_repo() {
    git clone https://github.com/archae0pteryx/nix ~/.config/nix
    cd ~/.config/nix

}

main() {
    prompt_sudo "Bootstraping..." 
    
    cd ~

    command -v git >/dev/null 2>&1 || error "git is not installed"
    command -v curl >/dev/null 2>&1 || error "curl is not installed"

    if ! command -v brew >/dev/null 2>&1; then
        log "Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi

    if ! command -v nix >/dev/null 2>&1; then
        log "Installing Nix..."
        sh <(curl -L https://nixos.org/nix/install)
    fi

    if [ ! -f ~/.ssh/id_ed25519 ]; then
        ssh-keygen -t ed25519 -f "$HOME/.ssh/id_ed25519" -N "" -q
    fi

    if [ ! -d ~/.config/nix-darwin ]; then
        setup_nix_darwin
    fi

    if ! git config --get user.name; then
        git_config
    fi

    if [ ! -d ~/.config/nix ]; then
        setup_nix_repo
    fi
}

# Allow sourcing or direct execution
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi

# #!/usr/bin/env bash

# set -euo pipefail



# # Optional: Prompt with a custom message


# # Main script
# main() {
#     # Prompt for sudo with a custom message
#     prompt_sudo "This script needs sudo to install system-wide tools"

#     # Your script logic here
#     sudo some_command
#     sudo another_command
# }

# # Run main only if script is executed directly
# if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
#     main "$@"
# fi
