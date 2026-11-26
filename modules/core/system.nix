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
  nix = {
    settings = {
      # Nix Flakes
      experimental-features = [
        "nix-command"
        "flakes"
      ];

      # Use current community caches for CUDA-enabled packages and Noctalia.
      extra-substituters = [
        "https://cache.nixos-cuda.org"
        "https://noctalia.cachix.org"
      ];
      extra-trusted-public-keys = [
        "cache.nixos-cuda.org:74DUi4Ye579gUqzH4ziL9IyiJBlDpMRn9MBN8oNan9M="
        "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="
      ];
    };

    optimise.automatic = true;

    # Remove generations older than two weeks during weekly garbage collection.
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 14d";
    };
  };

  boot = {
    loader = {
      systemd-boot = {
        enable = true;
        editor = false;
        # nix.gc removes old generations; this only caps boot entries.
        configurationLimit = 20;
      };
      efi.canTouchEfiVariables = true;
    };

    # Plymouth boot splash: include only the selected cybernetic theme.
    plymouth = {
      enable = true;
      theme = "cybernetic";
      themePackages = [
        (pkgs.adi1090x-plymouth-themes.override {
          selected_themes = [ "cybernetic" ];
        })
      ];
    };

    # Keep the boot screen clean while retaining the systemd-boot menu.
    consoleLogLevel = 0;
    kernelParams = [
      "quiet"
      "loglevel=3"
      "rd.systemd.show_status=false"
      "systemd.show_status=false"
    ];
  };

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

  # System-wide packages.
  environment.systemPackages = with pkgs; [
    gparted
    mpvpaper
    python3
  ];
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
