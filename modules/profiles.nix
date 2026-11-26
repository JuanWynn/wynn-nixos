{ lib, username, ... }:

{
  specialisation = {
    work.configuration = {
      hardware.steam-hardware.enable = lib.mkForce false;
      programs = {
        steam.enable = lib.mkForce false;
        gamemode.enable = lib.mkForce false;
      };
      services.pipewire.lowLatency.enable = lib.mkForce true;
      home-manager.users.${username}.wynn.gaming.enable = lib.mkForce false;
    };

    gaming.configuration = {
      hardware.steam-hardware.enable = lib.mkForce true;
      programs = {
        steam.enable = lib.mkForce true;
        gamemode = {
          enable = lib.mkForce true;
          settings.general.desiredgov = lib.mkForce "performance";
        };
      };
      services.pipewire.lowLatency.enable = lib.mkForce false;
      home-manager.users.${username}.wynn.gaming.enable = lib.mkForce true;
    };
  };
}
