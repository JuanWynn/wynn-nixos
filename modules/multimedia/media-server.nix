{ config, pkgs, ... }:

{
  virtualisation.podman = {
    enable = true;
    defaultNetwork.settings.dns_enabled = true;
  };

  # Start this rootless Compose stack manually after logging in as wynn.
  systemd.user.services.media-server-stack = {
    description = "Wynn media server stack (Podman Compose)";
    unitConfig.ConditionPathIsMountPoint = "/mnt/data";
    path = [
      config.virtualisation.podman.package
      pkgs.podman-compose
      "/run/wrappers"
    ];

    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      WorkingDirectory = "/home/wynn/media-server";
      ExecStart = "${pkgs.podman-compose}/bin/podman-compose -f ${./compose.yaml} up -d";
      ExecStop = "${pkgs.podman-compose}/bin/podman-compose -f ${./compose.yaml} stop";
      TimeoutStartSec = 0;
    };
  };
}
