
{ ... }:

{
  imports = [
    ./apps
    ./programs/git.nix
  ];

  # User information
  home.username = "wynn";
  home.homeDirectory = "/home/wynn";

  # Home Manager state version
  home.stateVersion = "26.11";
}


