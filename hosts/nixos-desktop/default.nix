{ config, pkgs, lib, username, ... }: {
  imports = [
    ../../modules/system/base.nix
    ./hardware-configuration.nix
    ./disko-config.nix
  ];

  networking.hostName = "nixos-desktop";

  systemd.network.wait-online.anyInterface = true;
  networking.networkmanager.enable = lib.mkForce true;
  networking.firewall.enable = lib.mkForce false;
  services.tailscale.enable = lib.mkForce false;
  hardware.bluetooth.enable = lib.mkForce false;
}
