# NixOS profiles

The system keeps its current default configuration and adds two optional
specialisations. Select one from the boot menu, or switch from the running
system:

```sh
sudo /run/current-system/specialisation/work/bin/switch-to-configuration switch
sudo /run/current-system/specialisation/gaming/bin/switch-to-configuration switch
```

The `work` profile enables the optional PipeWire low-latency settings and omits
Steam, GameMode, and the Home Manager emulator packages. It keeps the creative
and multimedia applications. The `gaming` profile includes Steam and emulators
and enables GameMode's performance governor setting. The ordinary system
configuration retains the existing defaults.

To return to the ordinary configuration, run:

```sh
sudo nixos-rebuild switch --flake .#nixos
```

Specialisations are built as additional system generations. Their binaries and
closures use additional disk space while installed.
