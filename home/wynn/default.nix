{ ... }:

{
  imports = [
    ./apps
    ./desktop/cursor.nix
    ./desktop/niri.nix
    ./desktop/noctalia.nix
    ./programs/git.nix
    ./programs/spicetify.nix
    ./shell/bash.nix
  ];

  # User information
  home.username = "wynn";
  home.homeDirectory = "/home/wynn";

  # Home Manager state version
  home.stateVersion = "26.11";
}
