{ pkgs, ... }:

{
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
}
