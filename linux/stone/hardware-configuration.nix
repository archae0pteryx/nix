# PLACEHOLDER - Replace with output from:
#   nixos-generate-config --show-hardware-config
# on the stone machine
{ config, lib, pkgs, modulesPath, ... }:
{
  imports = [ ];

  # Placeholder values - MUST be replaced with actual hardware config
  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usb_storage" "sd_mod" ];
  boot.kernelModules = [ "kvm-intel" ];

  fileSystems."/" = {
    device = "/dev/disk/by-label/nixos";
    fsType = "ext4";
  };

  swapDevices = [ ];

  networking.useDHCP = lib.mkDefault true;
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}
