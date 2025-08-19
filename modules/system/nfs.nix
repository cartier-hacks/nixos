{ lib, pkgs, ... }:

let
  nasIp = "10.89.0.15";
  baseMnt = "/mnt/main";
  shares = [
    "backups"
    "container-data"
    "cartier"
  ];

  configureShare = share: {
    name = "/mnt/${share}";
    value = {
      device = "${nasIp}:${baseMnt}/${share}";
      fsType = "nfs";
      options = [
        "x-systemd.automount"
        "noauto"
        "rw"
        "vers=4"

        # make Nautilus/Dolphin/Any File Manager show it with a friendly name/icon
        "x-gvfs-show"
        "x-gvfs-name=NAS — ${share}"
        "x-gvfs-icon=network-server"
      ];
    };
  };

  shareConfig = map configureShare shares;
  fsConfig = builtins.listToAttrs shareConfig;

in
{
  # Enable NFS client support
  boot.supportedFilesystems = [ "nfs" ];
  services = {
    rpcbind.enable = true; # Required for NFS
    gvfs.enable = true;
    udisks2.enable = true;
  };

  # Add NFS utilities
  environment.systemPackages = with pkgs; [
    nfs-utils
  ];

  fileSystems = fsConfig;
  systemd.tmpfiles.rules = map (share: "d /mnt/${share} 0755 root root -") shares;
}
