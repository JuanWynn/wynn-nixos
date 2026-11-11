{ ... }:

{
  # Secondary NTFS drive
  fileSystems."/mnt/data" = {
    device = "/dev/disk/by-uuid/DCB28BAEB28B8BA8";
    fsType = "ntfs";

    options = [
      "rw"
      "uid=1000"
      "gid=100"
      "umask=002"
      "nofail"
    ];
  };
}
