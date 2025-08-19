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
