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
  ];
  
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

  fileSystems."/mnt/working-files" = {
    device = "/dev/disk/by-uuid/BE8EBBDA8EBB8A03";
    fsType = "ntfs";
    options = [
      "uid=1000" # your user ID (check with `id -u`)
      "gid=100" # your primary group ID (check with `id -g`)
      "dmask=022" # dir permissions
      "fmask=133" # file permissions
      "nofail"

      # make Nautilus show it with a friendly name/icon
      "x-gvfs-show"
      "x-gvfs-name=Working Files"
    ];
  };

  environment = {
    systemPackages = with pkgs; [
      pkgs.ntfs3g
    ];
  };
}
