{ lib, ... }: {
  boot.initrd.availableKernelModules = lib.mkDefault [
    "ahci" "virtio" "virtio_blk" "virtio_pci" "virtio_net"
    "sd_mod" "usb_storage" "xhci_pci"
  ];

  boot.loader.grub.device = lib.mkDefault "/dev/vda";
  boot.loader.grub.efiSupport = lib.mkForce false;
  boot.loader.grub.efiInstallAsRemovable = lib.mkForce false;

  fileSystems."/" = lib.mkDefault {
    device = "/dev/disk/by-label/nixos";
    fsType = "ext4";
  };
}
