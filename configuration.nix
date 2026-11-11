
# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page,
# on https://search.nixos.org/options and in the NixOS manual.


{ config, lib, pkgs, ... }:
{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

#Nix Flakes
nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Networking
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;
  networking.networkmanager.wifi.backend = "iwd";

  # Time zone
  time.timeZone = "America/Bogota";

  # Internationalisation
  i18n.defaultLocale = "en_US.UTF-8";

  console = {
    font = "Lat2-Terminus16";
    useXkbConfig = true;
  };

  services.xserver.xkb.layout = "latam";

  # X11
  # services.xserver.enable = true;

  # Niri
  programs.niri.enable = true;
  programs.xwayland.enable = true;

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${config.programs.niri.package}/bin/niri-session";
        user = "wynn";
      };
    };
  };

  # Graphics drivers
  hardware.graphics.enable = true;

  services.xserver.videoDrivers = [
    "amdgpu"
    "nvidia"
  ];

  hardware.nvidia = {
    modesetting.enable = true;
    open = true;
    nvidiaSettings = true;

    prime = {
      offload.enable = true;
      offload.enableOffloadCmd = true;

      amdgpuBusId = "PCI:5@0:0:0";
      nvidiaBusId = "PCI:1@0:0:0";
    };
  };

  # Mount second disk
  fileSystems."/mnt/data" = {
    device = "/dev/disk/by-uuid/DCB28BAEB28B8BA8";
    fsType = "ntfs";
    options = [
      "rw"
      "uid=1000"
      "gid=100"
      "umask=002"
      "nofail"
    ];
  };

  # Noctalia
  programs.noctalia.systemd.enable = true;
  programs.noctalia.enable = true;

  systemd.user.services.niri.enableDefaultPath = false;

  # Printing
  # services.printing.enable = true;

  # Audio configuration: PipeWire
  services.pulseaudio.enable = false;

  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;

    alsa.enable = true;
    alsa.support32Bit = true;

    pulse.enable = true;
    jack.enable = true;
  };

  # Touchpad
  # services.libinput.enable = true;

  # User account
  users.users.wynn = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];

    packages = with pkgs; [
      tree
      nano
      vim
      discord
      alacritty
      vscode
      git
      gitkraken
      fastfetch
      wget
      yazi
      kdePackages.dolphin
      neovim
      pulseaudio
    ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Programs
  programs.firefox.enable = true;

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };

  hardware.steam-hardware.enable = true;
  programs.gamemode.enable = true;

  # System packages
  environment.systemPackages = with pkgs; [
    xwayland-satellite
  ];

  # OpenSSH
  # services.openssh.enable = true;

  # Firewall
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # networking.firewall.enable = false;

  # System configuration version
  system.stateVersion = "26.11";
}
