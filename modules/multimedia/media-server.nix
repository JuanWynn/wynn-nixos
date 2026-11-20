
{ config, pkgs, ... }:

{

  users.users.wynn.autoSubUidGidRange = true;

  virtualisation.podman = {
    enable = true;

    # DNS interno para la red de contenedores
    defaultNetwork.settings.dns_enabled = true;
  };

  environment.systemPackages = with pkgs; [
    podman-compose
  ];

  # Servicio manual administrado por systemd del usuario
  systemd.user.services.media-server-stack = {
    description = "Wynn Media Server Stack";

    after = [ "network-online.target" ];

    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;

      WorkingDirectory = "/home/wynn/media-server";

      ExecStart = "${pkgs.podman-compose}/bin/podman-compose up -d";
      ExecStop = "${pkgs.podman-compose}/bin/podman-compose down";
    };
  };
}
