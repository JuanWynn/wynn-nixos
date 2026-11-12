
{ ... }:

{
  # Steam
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };

  # Steam hardware support
  hardware.steam-hardware.enable = true;

  # GameMode
  programs.gamemode = {
    enable = true;

    settings = {
      general = {
        desiredgov = "performance";
        defaultgov = "schedutil";
      };
    };
  };
}
  



