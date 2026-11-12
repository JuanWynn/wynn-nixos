
{ ... }:

{
  services.syncthing = {
    enable = true;
    user = "wynn";
    dataDir = "/home/wynn";
    configDir = "/home/wynn/.config/syncthing";
    openDefaultPorts = true;
  };
}
