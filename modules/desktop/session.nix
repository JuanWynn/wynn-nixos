{ pkgs, username, ... }:

let
  astronautTheme = pkgs.sddm-astronaut.override {
    embeddedTheme = "black_hole";
  };
in
{
  # Niri
  programs.niri.enable = true;
  programs.xwayland.enable = true;

  # Noctalia Greeter provides the pre-session login screen through greetd.
  services.displayManager.noctalia-greeter = {
    # Keep its configuration so it can be re-enabled instead of SDDM below.
    # Only one display manager should be enabled at a time.
    enable = false;

    settings = {
      session.default = "niri";
      user.default = username;

      appearance = {
        scheme = "Synced";
        theme_mode = "dark";
        hide_logo = true;
        font_family = "Space Grotesk";
        wallpaper.path = "color:#101116";

        palette = {
          primary = "#FF6A00";
          on_primary = "#101116";
          secondary = "#168CFF";
          on_secondary = "#FFFFFF";
          tertiary = "#FFC247";
          on_tertiary = "#101116";
          error = "#FF5268";
          on_error = "#101116";
          surface = "#101116";
          on_surface = "#F4F1EA";
          surface_variant = "#252936";
          on_surface_variant = "#A6A9B5";
          outline = "#414654";
          shadow = "#08090D";
          hover = "#303746";
          on_hover = "#F4F1EA";
        };
      };

      clock = {
        enabled = true;
        position = "above-panel";
        time_format = "{:%H:%M}";
        date_format = "%A, %e %B";
      };
    };
  };

  # SDDM with the Astronaut theme. To switch back, disable SDDM and set
  # services.displayManager.noctalia-greeter.enable = true above.
  services.displayManager.sddm = {
    enable = true;
    package = pkgs.kdePackages.sddm;
    theme = "sddm-astronaut-theme";
    extraPackages = [ astronautTheme ];
    wayland.enable = true;
  };

  # Niri environment
  systemd.user.services.niri.enableDefaultPath = false;

  # XWayland compatibility
  environment.systemPackages = with pkgs; [
    xwayland-satellite
    astronautTheme
  ];
}
