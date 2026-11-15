{ config, pkgs,  ... }:

{
  # Niri
  programs.niri.enable = true;
  programs.xwayland.enable = true;

  # Display manager
  services.greetd = {
    enable = true;

    settings = {
      default_session = {
        command = "${config.programs.niri.package}/bin/niri-session";
        user = "wynn";
      };
    };
  };
  # Niri environment
  systemd.user.services.niri.enableDefaultPath = false;

  # XWayland compatibility
  environment.systemPackages = with pkgs; [
    xwayland-satellite
  ];
}
