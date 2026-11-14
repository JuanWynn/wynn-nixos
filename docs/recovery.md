# Wynn NixOS — Recovery Guide

Procedimiento para recuperar la configuración de Wynn NixOS después de una reinstalación.

## 1. Requisitos

- Una instalación funcional de NixOS.
- Acceso al repositorio `JuanWynn/wynn-nixos`.
- Copia de seguridad de la clave privada age.
- Acceso a Internet.

## 2. Clonar el repositorio

    git clone https://github.com/JuanWynn/wynn-nixos.git
    cd wynn-nixos

## 3. Restaurar la clave age

Conectar la USB e identificar su partición:

    lsblk -f

Montar la partición correspondiente (sustituir `/dev/sdX1`):

    sudo mkdir -p /mnt/usb
    sudo mount /dev/sdX1 /mnt/usb

Restaurar la clave privada:

    sudo install -D -m 600 /mnt/usb/sops-backup/keys.txt /var/lib/sops-nix/key.txt

Desmontar la USB:

    sudo umount /mnt/usb

## 4. Reconstruir el sistema

Desde la raíz del repositorio:

    sudo nixos-rebuild dry-build --flake .#nixos

Si la validación termina correctamente:

    sudo nixos-rebuild switch --flake .#nixos

## 5. Recuperación de la contraseña

El hash de la contraseña de `wynn` está almacenado en `secrets/wynn.yaml`, cifrado mediante SOPS con age.

La clave privada restaurada permite descifrarlo durante la activación de NixOS.

La configuración utiliza `hashedPasswordFile` y `neededForUsers` para que el secreto esté disponible durante la creación de usuarios.

Con `users.mutableUsers = true`, la contraseña de una cuenta existente no se fuerza en cada reconstrucción. En una instalación limpia, el usuario se crea utilizando el hash declarado.

## 6. Seguridad

- Nunca subir la clave privada age al repositorio.
- Mantener la copia de seguridad en un lugar seguro.
- No guardar versiones descifradas de `secrets/wynn.yaml`.
- Conservar `secrets/wynn.yaml` y `.sops.yaml` versionados.
- Si se pierde la clave privada, los secretos cifrados con ella no podrán recuperarse.
