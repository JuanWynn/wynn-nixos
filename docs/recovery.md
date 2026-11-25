# Wynn NixOS — Recovery Guide

Procedure for recovering Wynn NixOS after a reinstall.

## 1. Requirements

- A working NixOS installation.
- Access to the `JuanWynn/wynn-nixos` repository.
- A backup of the age private key.
- Internet access.

## 2. Clone the repository

    git clone https://github.com/JuanWynn/wynn-nixos.git
    cd wynn-nixos

The versioned configuration targets the ASUS TUF Gaming FX505DV. Before deploying it on another machine, replace `hardware-configuration.nix` with the file generated for that machine and review the GPU identifiers in `modules/hardware/graphics.nix` and the data volume UUID in `modules/hardware/storage.nix`. Do not change `system.stateVersion` as part of a hardware migration.

## 3. Restore the age key

Connect the USB drive and identify its partition:

    lsblk -f

Mount the relevant partition (replace `/dev/sdX1`):

    sudo mkdir -p /mnt/usb
    sudo mount /dev/sdX1 /mnt/usb

Restore the private key:

    sudo install -D -m 600 /mnt/usb/sops-backup/keys.txt /var/lib/sops-nix/key.txt

Unmount the USB drive:

    sudo umount /mnt/usb

## 4. Rebuild the system

From the repository root:

    sudo nixos-rebuild dry-build --flake .#nixos

The Flake check evaluates the NixOS configuration and validates Niri syntax:

    nix flake check

If validation succeeds:

    sudo nixos-rebuild switch --flake .#nixos

## 5. Password recovery

The `wynn` password hash is stored in `secrets/wynn.yaml`, encrypted with SOPS and age.

The restored private key allows NixOS to decrypt it during activation.

The configuration uses `hashedPasswordFile` and `neededForUsers` to make the secret available when users are created.

With `users.mutableUsers = true`, a password change made with `passwd` updates the local account but does not update the encrypted hash in SOPS. The repository hash is used when creating the account on a clean installation; keep it synchronized if you want the same password to be restored there.

## 6. Security

- Never upload the age private key to the repository.
- Keep the backup in a secure location.
- Do not store decrypted versions of `secrets/wynn.yaml`.
- Keep `secrets/wynn.yaml` and `.sops.yaml` versioned.
- If the private key is lost, secrets encrypted to it cannot be recovered.
