{ ... }:

{
  imports = [
    # Host-specific hostname, hardware identifiers, and filesystem UUIDs.
    ./hosts/nixos

    # Core
    ./modules/core/system.nix
    ./modules/core/networking.nix
    ./modules/core/users.nix

    # Hardware
    ./modules/hardware/graphics.nix
    ./modules/hardware/power.nix
    ./modules/services/syncthing.nix
    ./modules/backup/borgmatic.nix
    ./modules/profiles.nix

    # Desktop
    ./modules/desktop/session.nix

    # Audio
    ./modules/audio/pipewire.nix
    ./modules/audio/pipewire-low-latency.nix

    # Gaming
    ./modules/gaming/steam.nix

    # Multimedia services
    ./modules/multimedia/media-server.nix

  ];

  # Backups stay disabled until a suitable external or remote repository is chosen.
  # wynn.backups = {
  #   enable = true;
  #   repository = "/path/to/backup-repository";
  # };

  # Browser
  programs.firefox.enable = true;
}
