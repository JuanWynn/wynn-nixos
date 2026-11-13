{ ... }:

{
  # Nix configuration
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Automatic garbage collection
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 14d";
  };

  # Automatic store optimisation
  nix.optimise.automatic = true;

  # Bootloader
  boot.loader.systemd-boot = {
    enable = true;
    configurationLimit = 10;
  };

  boot.loader.efi.canTouchEfiVariables = true;

  # ZRAM
  zramSwap.enable = true;

  # System settings
  time.timeZone = "America/Bogota";
  i18n.defaultLocale = "en_US.UTF-8";

  console = {
    font = "Lat2-Terminus16";
    useXkbConfig = true;
  };

  services.xserver.xkb.layout = "latam";

  nixpkgs.config.allowUnfree = true;

  # Preserve compatibility with the existing installation
  system.stateVersion = "26.11";
}