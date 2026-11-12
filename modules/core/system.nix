{ ... }:

{
  # Nix Flakes
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Time zone
  time.timeZone = "America/Bogota";

  # Internationalisation
  i18n.defaultLocale = "en_US.UTF-8";

  console = {
    font = "Lat2-Terminus16";
    useXkbConfig = true;
  };

  services.xserver.xkb.layout = "latam";

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # System configuration version
  system.stateVersion = "26.11";
}
