
{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # System utilities
    tree
    wget
    fastfetch

    # Editors and development
    nano
    vim
    neovim
    vscode
    git
    gitkraken

    # Desktop applications
    discord
    alacritty
    kdePackages.dolphin
    yazi

    # Audio utilities
    pulseaudio
  ];
}
