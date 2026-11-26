{ ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./storage.nix
  ];

  networking.hostName = "nixos";

  # PRIME bus identifiers for this ASUS TUF FX505DV.
  hardware.nvidia.prime = {
    amdgpuBusId = "PCI:5@0:0:0";
    nvidiaBusId = "PCI:1@0:0:0";
  };
}
