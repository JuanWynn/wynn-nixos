
{ pkgs, ... }:

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

    # Editors and development
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
    alacritty
    kdePackages.dolphin
    kdePackages.ark
    kdePackages.okular
    kdePackages.gwenview
    yazi
    yacreader
    swaylock
    playerctl
    brightnessctl

    # Office
    libreoffice-qt

    # Multimedia
    vlc
    blender
    gimp
    inkscape
    obs-studio
    ffmpeg
    imagemagick

    # Communication
    discord

    # Audio
    pulseaudio
    qpwgraph

    # Compression
    unzip
    zip
    p7zip
  ];
}
