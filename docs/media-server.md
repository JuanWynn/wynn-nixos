# Media server stack

The stack is managed by the rootless `media-server-stack` Podman Compose user
service. It is deliberately not enabled at boot; start it after logging in as
`wynn`:

```sh
systemctl --user start media-server-stack
systemctl --user status media-server-stack
podman ps
```

Stop it with `systemctl --user stop media-server-stack`. The unit uses the
versioned [`modules/multimedia/compose.yaml`](../modules/multimedia/compose.yaml)
file. Container configuration remains under
`/home/wynn/media-server/config`, and media files remain under
`/mnt/data/media`; neither data directory is stored in this repository.
The user configuration directories already exist on this host. The
`/mnt/data` ext4 mount must be present before starting the unit; the unit is
skipped otherwise. The media library directories are not present yet. Create
them on the mounted data volume before configuring libraries:

```sh
mkdir -p /mnt/data/media/movies /mnt/data/media/tv
```

The web interfaces bind to localhost:

| Service | Local address |
|---|---|
| qBittorrent | `127.0.0.1:8080` |
| Prowlarr | `127.0.0.1:9696` |
| Sonarr | `127.0.0.1:8989` |
| Radarr | `127.0.0.1:7878` |
| Bazarr | `127.0.0.1:6767` |
| Jellyfin | `127.0.0.1:8096` |

qBittorrent also publishes TCP and UDP port `6881` on host interfaces for
incoming peer connections. The NixOS firewall is not opened by this module;
inbound access may also depend on the router and network.

Check startup logs with:

```sh
journalctl --user -u media-server-stack
```

After applying the NixOS configuration, confirm the manual start and stop on
the host. Flake evaluation cannot verify container startup or media access.
