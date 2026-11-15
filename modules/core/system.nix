{ pkgs, ... }:

let
  spaceGroteskRevision = "7085eb89a950e85db5b166b7a58d414544b4140c";

  spaceGroteskFont = pkgs.fetchurl {
    name = "SpaceGrotesk.ttf";
    url = "https://raw.githubusercontent.com/google/fonts/${spaceGroteskRevision}/ofl/spacegrotesk/SpaceGrotesk%5Bwght%5D.ttf";
    hash = "sha256-rK1t4fyTQ29cDx9BN3Ue8E8a6jBj5wNlNZcP/PvXn3I=";
  };

  spaceGroteskLicense = pkgs.fetchurl {
    name = "SpaceGrotesk-OFL.txt";
    url = "https://raw.githubusercontent.com/google/fonts/${spaceGroteskRevision}/ofl/spacegrotesk/OFL.txt";
    hash = "sha256-VkzlZcNxxeW78oYAZWWnyapVqfVufKWNVuBdZJ3WGnI=";
  };

  spaceGrotesk = pkgs.stdenvNoCC.mkDerivation {
    pname = "space-grotesk";
    version = "git-${builtins.substring 0 7 spaceGroteskRevision}";
    src = spaceGroteskFont;
    dontUnpack = true;

    installPhase = ''
      install -Dm644 "$src" "$out/share/fonts/truetype/SpaceGrotesk.ttf"
      install -Dm644 ${spaceGroteskLicense} "$out/share/licenses/space-grotesk/OFL.txt"
    '';

    meta = {
      description = "Space Grotesk variable font";
      homepage = "https://fonts.google.com/specimen/Space+Grotesk";
      license = pkgs.lib.licenses.ofl;
      platforms = pkgs.lib.platforms.all;
    };
  };
in
{
  # Nix Flakes
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Plymouth boot splash: include only the selected cybernetic theme.
  boot.plymouth = {
    enable = true;
    theme = "cybernetic";
    themePackages = [
      (pkgs.adi1090x-plymouth-themes.override {
        selected_themes = [ "cybernetic" ];
      })
    ];
  };

  # Keep the boot screen clean while retaining the systemd-boot menu.
  boot.consoleLogLevel = 0;
  boot.kernelParams = [
    "quiet"
    "loglevel=3"
    "rd.systemd.show_status=false"
    "systemd.show_status=false"
  ];

  # Time zone
  time.timeZone = "America/Bogota";

  # Internationalisation
  i18n.defaultLocale = "en_US.UTF-8";

  # Bluetooth through BlueZ; power the controller on during boot.
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  fonts.packages = [ spaceGrotesk ];

  # Graphical partition editor; authorization is handled through polkit.
  environment.systemPackages = [ pkgs.gparted ];
  security.polkit.enable = true;

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
