_:

{
  services = {
    power-profiles-daemon.enable = true;

    # Keep ASUS hardware controls while leaving power profiles to PPD.
    asusd = {
      enable = true;
      asusdConfig.text = ''
        (
          change_platform_profile_on_ac: false,
          change_platform_profile_on_battery: false,
          platform_profile_linked_epp: false,
        )
      '';
    };

    fstrim.enable = true;
    smartd.enable = true;
    colord.enable = true;
  };

  zramSwap.enable = true;
}
