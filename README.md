# Troubleshoot

```
# re-bootstrap socket? why does this happen?

sudo launchctl bootstrap system /Library/LaunchDaemons/org.nixos.nix-daemon.plist 2>/dev/null || true
sudo launchctl kickstart -k system/org.nixos.nix-daemon


# main rebuild command
sudo -H nix run nix-darwin/master#darwin-rebuild -- switch --flake $HOME/.config/nix/darwin#eyepop

# check if disabled
sudo launchctl print-disabled system
# enable
sudo launchctl enable system/org.nixos.nix-daemon


# if permissions with socket
sudo launchctl unload /Library/LaunchDaemons/org.nixos.nix-daemon.plist
sudo launchctl load /Library/LaunchDaemons/org.nixos.nix-daemon.plist


# if disk locked with unknown password
security find-generic-password -s "Nix Store" -w

```
