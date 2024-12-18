curl --proto '=https' --tlsv1.2 -sSf -L https://github.com/NixOS/nix/raw/master/scripts/sequoia-nixbld-user-migration.sh | bash -
dscl . list /Users UniqueID | grep _nixbld | sort -n -k2