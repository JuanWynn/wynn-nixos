{ ... }:

{
  # Hostname
  networking.hostName = "nixos";

  # NetworkManager
  networking.networkmanager.enable = true;

  # Wi-Fi backend
  networking.networkmanager.wifi.backend = "iwd";
}
