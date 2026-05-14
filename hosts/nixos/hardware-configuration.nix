{ lib, ... }:

{
  boot.initrd.availableKernelModules = lib.mkDefault [
    "ahci"
    "nvme"
    "sd_mod"
    "usb_storage"
    "xhci_pci"
  ];

  boot.loader.grub.efiSupport = lib.mkDefault true;
  boot.loader.grub.efiInstallAsRemovable = lib.mkDefault false;
  boot.loader.efi.canTouchEfiVariables = lib.mkDefault true;

  fileSystems."/" = lib.mkDefault {
    device = "/dev/disk/by-label/nixos";
    fsType = "ext4";
  };

  fileSystems."/boot" = lib.mkDefault {
    device = "/dev/disk/by-label/EFI";
    fsType = "vfat";
  };
}
