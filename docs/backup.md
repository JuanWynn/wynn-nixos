# Backups

The repository contains an optional Borgmatic setup. It is disabled until a
backup destination is chosen and the repository passphrase is added to SOPS.
No snapshots are created while it is disabled.

## Configure the destination and passphrase

Choose a local or remote Borg repository, then set the options in
`modules/backup/borgmatic.nix`'s consumer configuration (for example, in
`configuration.nix`):

```nix
wynn.backups = {
  enable = true;
  repository = "/path/to/backup-repository";
};
```

For a remote Borg repository, use the Borg URL in `repository`. Before
enabling the module, add `borgmatic-repository-passphrase` to the encrypted
`secrets/wynn.yaml` with `sops secrets/wynn.yaml`. Enter it only in the SOPS
editor; never put it in Nix configuration, shell history, or a plaintext file.
Then rebuild and switch the system so SOPS creates
`/run/secrets/borgmatic-repository-passphrase`.

Initialize a new repository once, using the same passphrase stored in SOPS:

```sh
sudo env BORG_PASSCOMMAND='cat /run/secrets/borgmatic-repository-passphrase' \
  borg init --encryption=repokey /path/to/backup-repository
```

For a remote destination, replace the final argument with its Borg URL. Protect
the repository itself; losing both the repository and its passphrase means the
backup cannot be recovered.

## What is included

The scheduled job backs up `/home/wynn`, `/home/wynn-nixos`, `/mnt/data`, and
`/etc/nixos`. It excludes `.cache` directories, `CACHEDIR.TAG` caches,
Downloads, Steam libraries, DaVinci Resolve `CacheClip`, `ProxyMedia`, and
`OptimizedMedia` folders, and the age private key locations. The
`/mnt/data` filesystem is a required dependency, so the service fails and
announces an error if that drive is not mounted.

Borgmatic runs daily and retains 7 daily, 4 weekly, and 6 monthly archives. It
also runs repository and archive consistency checks every two weeks. A failed
service writes an alert to the journal and broadcasts a message to logged-in
terminals. Check its status with:

```sh
systemctl list-timers borgmatic.timer
sudo systemctl status borgmatic.service
sudo journalctl -u borgmatic.service -u wynn-backup-failure.service
```

## Create and list snapshots

After configuring and switching, run the service once to create the first
snapshot:

```sh
sudo systemctl start borgmatic.service
sudo borgmatic list
```

The persistent daily timer starts future runs automatically. Its failures are
visible through the alert and system journal commands above.

## Test a restore

Create a harmless test file in the backed-up home directory, then run a backup:

```sh
printf 'backup restore check\n' > ~/backup-restore-test.txt
sudo systemctl start borgmatic.service
sudo borgmatic list --archive latest
```

Extract only that file to a temporary folder and compare the restored copy:

```sh
sudo mkdir -p /tmp/borg-restore-test
sudo borgmatic extract --archive latest \
  --path home/wynn/backup-restore-test.txt \
  --destination /tmp/borg-restore-test
cmp ~/backup-restore-test.txt \
  /tmp/borg-restore-test/home/wynn/backup-restore-test.txt
```

Remove the test file and temporary restore after the comparison succeeds.
The phase is verified only after a real snapshot has been listed and this
restore comparison succeeds on the chosen destination.
