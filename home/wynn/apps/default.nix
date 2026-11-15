{ pkgs, ... }:

let
  davinciResolveNvidia = pkgs.writeShellScriptBin "davinci-resolve-nvidia" ''
    exec env \
      __NV_PRIME_RENDER_OFFLOAD=1 \
      __GLX_VENDOR_LIBRARY_NAME=nvidia \
      QT_QPA_PLATFORM=xcb \
      ${pkgs.davinci-resolve}/bin/davinci-resolve "$@"
  '';
in

{
  home.packages = with pkgs; [
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
    nodejs
    pnpm

    # Nix development
    nixfmt
    nil
    statix

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
    blender
    gimp
    inkscape
    obs-studio
    davinciResolveNvidia
    ffmpeg
    imagemagick

    # RetroArch cores for the requested Nintendo and PlayStation systems
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

    # Communication
    vesktop

    # Audio
    pulseaudio
    qpwgraph

    # Compression
    unzip
    zip
    p7zip
  ];
}
