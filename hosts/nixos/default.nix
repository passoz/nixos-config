{ config, pkgs, lib, username, ... }:

let
  fl2000DrmLinux61 = pkgs.callPackage ../../pkgs/fl2000_drm {
    kernel = pkgs.linuxPackages_6_1.kernel;
  };
in
{
  imports = [
    ../../modules/system/base.nix
    ./hardware-configuration.nix
  ];

  networking.hostName = "nixos";

  services.displayManager.gdm.wayland = false;

  specialisation."linux-6_1-compat".configuration = {
    system.nixos.tags = [ "linux-6.1" "compat" "fl2000" "x11" ];

    boot.kernelPackages = pkgs.linuxPackages_6_1;
    boot.extraModulePackages = [ fl2000DrmLinux61 ];
    boot.kernelModules = [ "fl2000" "it66121" ];
    services.displayManager.gdm.wayland = lib.mkForce false;
  };
}
