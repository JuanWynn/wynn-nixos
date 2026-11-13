
{ config, pkgs, ... }:

{
  # Niri
  programs.niri.enable = true;
  programs.xwayland.enable = true;

  # Display manager: manual login with agreety
  services.greetd = {
    enable = true;

    settings = {
      default_session = {
        command = "${pkgs.greetd}/bin/agreety --cmd ${config.programs.niri.package}/bin/niri-session";
        user = "greeter";
      };
    };
  };

  # Noctalia
  programs.noctalia.systemd.enable = true;
  programs.noctalia.enable = true;

  # Niri environment
  systemd.user.services.niri.enableDefaultPath = false;

  # XWayland compatibility
  environment.systemPackages = with pkgs; [
    xwayland-satellite
  ];
}

