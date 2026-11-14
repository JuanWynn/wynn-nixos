{ ... }:

{
  # Hostname
  networking.hostName = "nixos";

  # NetworkManager
  networking.networkmanager = {
    enable = true;
    wifi.backend = "iwd";
  };

  # iwd
  networking.wireless.iwd.enable = true;
  networking.wireless.enable = false;
}
