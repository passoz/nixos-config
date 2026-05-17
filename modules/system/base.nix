{ config, pkgs, lib, username, ... }:

{
  nixpkgs.config.allowUnfree = true;

  networking.networkmanager.enable = true;
  networking.firewall.enable = true;

  services.xserver.enable = true;

  time.timeZone = "America/Sao_Paulo";

  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_TIME = "pt_BR.UTF-8";
    LC_MONETARY = "pt_BR.UTF-8";
  };

  boot.loader.timeout = 8;
  boot.consoleLogLevel = 3;
  boot.initrd.verbose = false;
  boot.kernelParams = [
    "quiet" "splash" "loglevel=3"
    "rd.systemd.show_status=auto"
    "rd.udev.log_level=3"
    "vt.global_cursor_default=0"
  ];
  boot.plymouth.enable = true;
  boot.plymouth.theme = "bgrt";

  services.desktopManager.gnome.enable = true;
  services.displayManager.gdm.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  hardware.graphics.enable = true;
  hardware.bluetooth.enable = true;

  services.tailscale.enable = true;

  environment.systemPackages = with pkgs; [
    winePackages.staging
  ];

  virtualisation.docker.enable = true;

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-color-emoji
    noto-fonts-cjk-sans
    nerd-fonts.mononoki
  ];

  programs.git.enable = true;

  users.users.passoz = {
    isNormalUser = true;
    extraGroups = [ "wheel" "docker" "audio" "video" ];
    initialPassword = "dtn5c7bj";
  };

  services.gvfs.enable = true;
  services.udisks2.enable = true;
  services.libinput.enable = true;

  boot.loader.grub.enable = true;
  boot.loader.grub.device = "nodev";

  specialisation."lightdm-cinnamon".configuration = {
    system.nixos.tags = [ "lightdm" "cinnamon" "x11" ];

    services.displayManager.gdm.enable = lib.mkForce false;
    services.desktopManager.gnome.enable = lib.mkForce false;

    services.xserver.displayManager.lightdm.enable = true;
    services.xserver.displayManager.lightdm.background = "#1f2335";
    services.xserver.displayManager.lightdm.greeters.gtk = {
      enable = true;
      theme = {
        package = pkgs.gnome-themes-extra;
        name = "Adwaita-dark";
      };
      iconTheme = {
        package = pkgs.adwaita-icon-theme;
        name = "Adwaita";
      };
      cursorTheme = {
        package = pkgs.adwaita-icon-theme;
        name = "Adwaita";
        size = 24;
      };
      indicators = [
        "~host" "~spacer" "~clock" "~spacer"
        "~session" "~language" "~a11y" "~power"
      ];
      clock-format = "%a, %d %b %H:%M";
      extraConfig = ''
        hide-user-image = false
        round-user-image = true
        highlight-logged-user = true
      '';
    };
  };

  system.stateVersion = "24.11";
}
