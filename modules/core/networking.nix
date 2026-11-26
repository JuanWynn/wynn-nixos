_:

{
  networking = {
    # NetworkManager
    networkmanager = {
      enable = true;
      wifi.backend = "iwd";
    };

    # iwd
    wireless.iwd.enable = true;
    wireless.enable = false;
  };
}
