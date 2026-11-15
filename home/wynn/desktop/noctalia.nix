{ inputs, ... }:

{
  imports = [
    inputs.noctalia.homeModules.default
    ./profiles/signal.nix
  ];

  programs.noctalia = {
    enable = true;
    systemd.enable = true;
  };
}
