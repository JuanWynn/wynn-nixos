{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.wynn.backups;
in
{
  options.wynn.backups = {
    enable = lib.mkEnableOption "encrypted Borg backups";

    repository = lib.mkOption {
      type = lib.types.nullOr lib.types.str;
      default = null;
      description = "Local path or Borg URL for the backup repository.";
    };
  };

  config = lib.mkIf cfg.enable {
    assertions = [
      {
        assertion = cfg.repository != null;
        message = "Set wynn.backups.repository before enabling backups.";
      }
    ];

    sops.secrets."borgmatic-repository-passphrase" = {
      sopsFile = ../../secrets/wynn.yaml;
      key = "borgmatic-repository-passphrase";
    };

    services.borgmatic = {
      enable = true;
      configurations.wynn = {
        source_directories = [
          "/home/wynn"
          "/home/wynn-nixos"
          "/mnt/data"
          "/etc/nixos"
        ];

        repositories = [
          {
            path = cfg.repository;
            label = "wynn";
          }
        ];

        encryption_passcommand = "${pkgs.coreutils}/bin/cat ${
          config.sops.secrets."borgmatic-repository-passphrase".path
        }";

        exclude_caches = true;
        exclude_patterns = [
          "**/.cache"
          "**/Downloads"
          "**/downloads"
          "**/steamapps"
          "**/SteamLibrary"
          "/home/wynn/.local/share/Steam"
          "/home/wynn/.steam"
          "**/CacheClip"
          "**/ProxyMedia"
          "**/OptimizedMedia"
          "/home/wynn/.config/sops/age/keys.txt"
          "/var/lib/sops-nix/key.txt"
        ]
        ++ lib.optional (cfg.repository != null) cfg.repository;

        keep_daily = 7;
        keep_weekly = 4;
        keep_monthly = 6;

        checks = [
          {
            name = "repository";
            frequency = "2 weeks";
          }
          {
            name = "archives";
            frequency = "2 weeks";
          }
        ];
      };
    };

    # Make failures visible to logged-in terminals and in the system journal.
    systemd.services.borgmatic = {
      requires = [ "mnt-data.mount" ];
      after = [ "mnt-data.mount" ];
      unitConfig.OnFailure = [ "wynn-backup-failure.service" ];
    };
    systemd.services.wynn-backup-failure = {
      description = "Announce a failed Wynn backup";
      path = [
        pkgs.systemd
        pkgs.util-linux
      ];
      serviceConfig.Type = "oneshot";
      script = ''
        message="Wynn backup failed. Check: systemctl status borgmatic.service"
        logger --priority=user.alert --tag=wynn-backup "$message"
        wall "$message"
      '';
    };
  };
}
