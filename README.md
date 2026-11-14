# Wynn NixOS

Personal NixOS configuration designed around a Wayland-first desktop, creative applications, development tools, gaming and a hybrid AMD/NVIDIA graphics setup.

**Version:** 1.2
**Status:** Active development

## System Overview

| Component | Configuration |
|---|---|
| Operating System | NixOS 26.11 |
| Architecture | x86_64-linux |
| Window Manager | Niri |
| Desktop Shell | Noctalia |
| Display Protocol | Wayland |
| Terminal | Alacritty |
| Login Manager | greetd |
| Browser | Firefox |
| Graphics | AMD Radeon Vega 10 + NVIDIA RTX 2060 |
| Audio | PipeWire |
| System Configuration | Nix Flakes |
| User Environment | Home Manager |
| Secrets Management | SOPS + age |

## Hardware

- **CPU:** AMD Ryzen 7 3750H
- **GPU:** NVIDIA GeForce RTX 2060 Mobile 6 GB
- **Integrated GPU:** AMD Radeon Vega 10
- **RAM:** 32 GB
- **Storage:** NVMe SSD and 2 TB HDD

## Included Software

### Development
- Visual Studio Code
- Neovim
- Git
- GitKraken
- Node.js
- pnpm
- Nix development tools

### Desktop and Utilities
- Firefox
- Dolphin
- Yazi
- Ark
- Okular
- Gwenview
- Alacritty
- Fastfetch
- btop

### Multimedia and Creative Tools
- Blender
- GIMP
- Inkscape
- OBS Studio
- VLC
- FFmpeg
- ImageMagick
- Spicetify

### Office and Communication
- LibreOffice
- Discord

### Gaming
- Steam
- GameMode
- Steam hardware support

## Features

- Declarative NixOS configuration.
- Flake-based dependency management with `flake.lock`.
- Modular system configuration.
- Home Manager integration.
- Niri Wayland compositor and Noctalia shell.
- Hybrid AMD/NVIDIA graphics configuration.
- NVIDIA PRIME render offload.
- XWayland compatibility.
- PipeWire with ALSA, PulseAudio and JACK support.
- Steam and GameMode integration.
- Persistent NTFS data partition mounted at `/mnt/data`.
- Declarative Spotify customization through Spicetify-Nix.
- Encrypted user password hash managed with SOPS and age.

## Repository Structure

```text
wynn-nixos/
├── config/
│   └── niri/
│       └── config.kdl
├── docs/
│   └── recovery.md
├── home/
│   └── wynn/
│       ├── apps/
│       │   └── default.nix
│       ├── programs/
│       │   ├── git.nix
│       │   └── spicetify.nix
│       ├── shell/
│       │   └── bash.nix
│       └── default.nix
├── modules/
│   ├── audio/
│   │   └── pipewire.nix
│   ├── core/
│   │   ├── networking.nix
│   │   ├── system.nix
│   │   └── users.nix
│   ├── desktop/
│   │   └── session.nix
│   ├── gaming/
│   │   └── steam.nix
│   └── hardware/
│       ├── graphics.nix
│       └── storage.nix
├── secrets/
│   └── wynn.yaml
├── .gitignore
├── .sops.yaml
├── configuration.nix
├── flake.lock
├── flake.nix
├── hardware-configuration.nix
└── README.md

Configuration layers
- NixOS Modules: system services, users, networking, hardware, audio, desktop session and gaming.
- Home Manager: user applications, Git, Spicetify and shell configuration.
- Config: desktop configuration files.
- Secrets: encrypted configuration managed through SOPS.
- Docs: recovery and maintenance documentation.
Usage
Clone the repository:

git clone https://github.com/JuanWynn/wynn-nixos.git
cd wynn-nixos

Validate the configuration before applying changes:

sudo nixos-rebuild dry-build --flake .#nixos

Apply the configuration:

sudo nixos-rebuild switch --flake .#nixos

Update Flake dependencies:

nix flake update

Validate the Flake:

nix flake check --no-build
Secrets Management
SOPS and age are used to encrypt sensitive configuration.
- .sops.yaml defines the encryption rules.
- secrets/wynn.yaml stores encrypted secrets.
- The age private key is stored outside the repository.
- The private key must be backed up securely.
Never commit or upload the age private key.

See docs/recovery.md for system recovery instructions.
Roadmap
- [x] Establish the base NixOS configuration.
- [x] Configure Niri and Noctalia.
- [x] Introduce Nix Flakes.
- [x] Modularize system configuration.
- [x] Integrate Home Manager.
- [x] Configure PipeWire audio support.
- [x] Configure hybrid AMD/NVIDIA graphics.
- [x] Integrate Steam and GameMode.
- [x] Organize user applications and development tools.
- [x] Integrate Spicetify-Nix.
- [x] Configure SOPS and age for secret management.
- [x] Document initial recovery procedure.
- [ ] Complete the first Flake-based system switch.
- [ ] Develop reusable development environments (DevShells).
- [ ] Improve CUDA support for creative and development workflows.
- [ ] Implement optional device synchronization.
- [ ] Introduce maintenance and system monitoring tools.
- [ ] Refine desktop appearance and visual identity.

Personal configuration maintained by Wynn.