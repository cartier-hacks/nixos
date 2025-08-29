{
  config,
  pkgs,
  inputs,
  hostname,
  assets,
  ...
}:
{
  imports = [
    ../common-config.nix
    ../../modules/system/nix-valet.nix
    ../../modules/system/device-management/logitech.nix
    ./hardware-configuration.nix
    ../../modules/system/gaming.nix
    #../../modules/home/common/obs.nix
  ];

  # Set primary monitor for SDDM login screen
  services.xserver.displayManager.sddm.settings = {
    General = {
      DisplayServer = "wayland";
    };
    Wayland = {
      CompositorCommand = "Hyprland";
    };
  };

  # Alternative: Set primary monitor via environment variable
  environment.variables = {
    WLR_DRM_PRIMARY = "DP-2"; # Main HP OMEN monitor
  };

  #Polkit for gparted
  security.polkit.enable = true;

  # Desktop Specific Hyprland Monitor Config
  home-manager.users.${config.users.users.cartier.name or "cartier"} = {
    wayland.windowManager.hyprland.settings.monitor = [
      # Main monitor (HP OMEN, right side, horizontal, 1440p @ 240Hz)
      "DP-2, 2560x1440@240, 1080x0, 1"
      # Secondary monitor (Samsung, left side, vertical, 1080p @ 239.76Hz)
      "DP-1, 1920x1080@239.76, 0x0, 1, transform, 1"
    ];
  };

  # Mount second hard drive
  boot = {
    supportedFilesystems = [
      "ntfs"
    ];
  };

  fileSystems."/home/cartier/gamer-drive" = {
    device = "/dev/disk/by-label/linux";
    fsType = "ext4";
    options = [
      "defaults"
      # "noatime"
      # "user"
    ];
  };
  fileSystems."/home/cartier/windows-drive" = {
    device = "/dev/disk/by-label/windows";
    fsType = "ntfs";
    options = [
      "defaults"
      "uid=1000"
      "gid=100"
      "umask=022"
      "fmask=133"
      "dmask=022"
    ];
  };
  systemd.tmpfiles.rules = [
    "d /home/cartier/gamer-drive 0755 cartier users -"
  ];

  environment = {
    systemPackages = with pkgs; [
      pkgs.ntfs3g
      gparted
      xorg.xrandr
    ];
  };
}
