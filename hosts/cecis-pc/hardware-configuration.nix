{ config, lib, pkgs, modulesPath, ... }:

{
  # Old OS
  fileSystems."/mnt/old" = {
    device = "/dev/nvme0n1p1";
    fsType = "ext4";
  };

  fileSystems."/mnt/media" = {
    device = "/dev/nvme2n1p1";
    fsType = "ext4";
  };
}