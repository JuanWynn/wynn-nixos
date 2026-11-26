_:

{
  # Secondary ext4 drive
  fileSystems."/mnt/data" = {
    device = "/dev/disk/by-uuid/b4613f44-5339-488a-ab2d-5c4cb3c9b67b";
    fsType = "ext4";

    options = [ "nofail" ];
  };
}
