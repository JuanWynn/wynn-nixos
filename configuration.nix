
{ ... }:

{
  imports = [
    # Hardware configuration
    ./hardware-configuration.nix

    # Core
    ./modules/core/system.nix
    ./modules/core/networking.nix
    ./modules/core/users.nix

    # Hardware
    ./modules/hardware/graphics.nix
    ./modules/hardware/storage.nix

    # Desktop
    ./modules/desktop/session.nix

    # Audio
    ./modules/audio/pipewire.nix

    # Gaming
    ./modules/gaming/steam.nix

    # Services
    ./modules/services/syncthing.nix
  ];

  # Browser
  programs.firefox.enable = true;
}