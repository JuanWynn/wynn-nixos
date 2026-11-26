{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:

let
  # Build Blender against Nixpkgs' CUDA-enabled package set without enabling
  # CUDA support for every package in the system package set.
  blenderCuda =
    (import inputs.nixpkgs {
      system = pkgs.stdenv.hostPlatform.system;
      config = {
        cudaSupport = true;
        allowUnfree = true;
      };
    }).blender;

  davinciResolveNvidia = pkgs.writeShellScriptBin "davinci-resolve-nvidia" ''
    exec env \
      __NV_PRIME_RENDER_OFFLOAD=1 \
      __GLX_VENDOR_LIBRARY_NAME=nvidia \
      QT_QPA_PLATFORM=xcb \
      ${pkgs.davinci-resolve}/bin/davinci-resolve "$@"
  '';
in

{
  options.wynn.gaming.enable = lib.mkOption {
    type = lib.types.bool;
    default = true;
    description = "Whether gaming emulators are installed in this profile.";
  };

  config.home.packages =
    (with pkgs; [
      # System utilities
      tree
      wget
      fastfetch
      pciutils
      mesa-demos
      btop
      ripgrep
      fd
      fzf
      jq
      playerctl
      brightnessctl

      # Editors and development
      nano
      neovim
      vscode
      gitkraken

      # Desktop and file management
      kdePackages.dolphin
      kdePackages.ark
      kdePackages.okular
      kdePackages.gwenview
      yazi
      yacreader

      # Office
      libreoffice-qt

      # Multimedia
      vlc
      stremio-linux-shell
      blenderCuda
      krita
      ardour
      gimp
      inkscape
      obs-studio
      davinciResolveNvidia
      ffmpeg
      imagemagick

      # Communication
      vesktop

      # Audio
      pulseaudio
      qpwgraph

      # Compression
      unzip
      zip
      p7zip
    ])
    ++ lib.optionals config.wynn.gaming.enable (
      with pkgs;
      [
        # RetroArch cores for the requested Nintendo and PlayStation systems.
        (retroarch.withCores (cores: [
          cores.nestopia # NES
          cores.snes9x # SNES
          cores.mupen64plus # Nintendo 64
          cores.swanstation # PlayStation
          cores.pcsx2 # PlayStation 2
          cores.ppsspp # PSP
          cores.sameboy # Game Boy and Game Boy Color
          cores.mgba # Game Boy Advance
          cores.melonds # Nintendo DS
          cores.citra # Nintendo 3DS
          cores.dolphin # GameCube
        ]))

        # Standalone emulator: no RetroArch libretro core is available for PS Vita.
        vita3k
      ]
    );
}
