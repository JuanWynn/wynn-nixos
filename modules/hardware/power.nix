{ ... }:

{
  services.power-profiles-daemon.enable = true;

  # Keep ASUS hardware controls while leaving power profiles to PPD.
  services.asusd = {
    enable = true;
    asusdConfig.text = ''
      (
        change_platform_profile_on_ac: false,
        change_platform_profile_on_battery: false,
        platform_profile_linked_epp: false,
      )
    '';
  };

  zramSwap.enable = true;
  services.fstrim.enable = true;
  services.smartd.enable = true;
  services.colord.enable = true;
}
