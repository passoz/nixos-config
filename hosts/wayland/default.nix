{ config, pkgs, lib, username, ... }:

{
  imports = [
    ../../modules/system/base.nix
    ./hardware-configuration.nix
  ];

  networking.hostName = "wayland";
}
