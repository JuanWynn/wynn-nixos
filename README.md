# Wynn NixOS

Personal NixOS desktop configuration, designed around a Wayland-first workflow, creative applications, development tools, and a hybrid AMD/NVIDIA graphics setup.

**Version:** 1.0
**Status:** Initial configuration

## System Overview

| Component | Configuration |
|---|---|
| Operating System | NixOS 26.11 |
| Desktop Environment | Niri |
| Desktop Shell | Noctalia |
| Display Protocol | Wayland |
| Terminal | Alacritty |
| Login Manager | greetd |
| Browser | Firefox |
| Graphics | AMD Radeon Vega 10 + NVIDIA RTX 2060 |
| Audio | PipeWire (planned) |

## Hardware

- **CPU:** AMD Ryzen 7 3750H
- **GPU:** NVIDIA GeForce RTX 2060 Mobile 6 GB
- **Integrated GPU:** AMD Radeon Vega 10
- **RAM:** 32 GB
- **Storage:** SSD

## Included Software

- Visual Studio Code
- Git and GitKraken
- Neovim
- Dolphin
- Yazi
- Discord
- Fastfetch

## Features

- Declarative system configuration through NixOS.
- Niri Wayland compositor.
- Noctalia desktop shell.
- Hybrid AMD/NVIDIA graphics configuration.
- NVIDIA PRIME render offload.
- Persistent NTFS data partition mounted at `/mnt/data`.
- XWayland compatibility for applications that require X11.

## Repository Structure

```text
wynn-nixos/
├── configuration.nix
└── README.md
```

## Usage

The main system configuration is maintained in `configuration.nix`.

To apply changes:

```bash
sudo nixos-rebuild switch
```

## Roadmap

- [ ] Complete desktop environment configuration.
- [ ] Improve multimedia workflow and audio support.
- [ ] Organize configuration into reusable modules.
- [ ] Introduce Nix flakes.
- [ ] Explore local development environments for CUDA.
- [ ] Implement automated maintenance and backups.

---

Personal configuration maintained by Wynn.