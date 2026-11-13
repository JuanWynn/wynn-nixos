
{ ... }:

{
  # Power management
  services.power-profiles-daemon.enable = true;

  # Battery and power information
  services.upower.enable = true;

  # Periodic SSD TRIM
  services.fstrim.enable = true;
}
