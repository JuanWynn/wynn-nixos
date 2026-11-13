# Wynn NixOS

Personal NixOS desktop configuration designed around a Wayland-first workflow, creative applications, development tools, gaming, and hybrid AMD/NVIDIA graphics.

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
| Configuration | Nix Flakes + NixOS Modules |
| User Environment | Home Manager |

## Hardware

- **CPU:** AMD Ryzen 7 3750H
- **GPU:** NVIDIA GeForce RTX 2060 Mobile 6 GB
- **Integrated GPU:** AMD Radeon Vega 10
- **RAM:** 32 GB
- **Storage:** 2 TB HDD/SSHD + 512 GB NVMe SSD

## Included Software

### Development

- Visual Studio Code
- Neovim
- Git
- GitKraken
- Node.js
- pnpm
- Python
- .NET SDK
- Nix development tools: nixfmt, nil and statix

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
- qpwgraph

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

- Declarative system configuration using NixOS.
- Flake-based configuration with locked dependencies.
- Modular system architecture.
- Home Manager integration for user-level applications and configuration.
- Niri Wayland compositor.
- Noctalia desktop shell.
- Hybrid AMD/NVIDIA graphics configuration.
- NVIDIA PRIME render offload.
- XWayland compatibility.
- PipeWire audio stack with ALSA and PulseAudio compatibility.
- RTKit configuration for audio scheduling support.
- Steam and GameMode integration.
- Syncthing device synchronization.
- NTFS data partition mounted at `/mnt/data`.
- Automatic Nix garbage collection and store optimization.
- ZRAM swap.
- Declarative Spotify customization through Spicetify-Nix.
- Reusable development environments through Nix DevShells.
- Automatic filesystem trimming.

## Repository Structure

```text
wynn-nixos/
├── config/
│   └── niri/
│       └── config.kdl
├── configuration.nix
├── flake.nix
├── flake.lock
├── hardware-configuration.nix
├── home/
│   └── wynn/
│       ├── apps/
│       │   └── default.nix
│       ├── default.nix
│       ├── desktop/
│       ├── programs/
│       │   ├── git.nix
│       │   └── spicetify.nix
│       └── shell/
│           └── bash.nix
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
│   ├── hardware/
│   │   ├── graphics.nix
│   │   ├── laptop.nix
│   │   └── storage.nix
│   └── services/
│       └── syncthing.nix
└── README.md
```

The repository separates system-level configuration from user-level configuration.

- **NixOS Modules:** system settings, networking, users, hardware, graphics, audio, desktop session, gaming and services.
- **Home Manager:** user applications, programs, shell configuration and personal environment.
- **Flakes:** dependency management, system configuration and reproducible development environments.
- **Desktop Configuration:** Niri configuration and future desktop customization.

`hardware-configuration.nix` contains machine-specific hardware and filesystem configuration. It must be regenerated when installing the system on different hardware or changing the system's storage layout.

## Development Environments

Wynn NixOS provides reusable development environments through Nix Flakes.

Each DevShell declares its own tools and dependencies without requiring additional global system packages.

### Available environments

| Environment | Tools | Intended use |
|---|---|---|
| Default | Git, nixfmt, nil, statix | Wynn NixOS configuration and maintenance |
| JavaScript | Node.js, pnpm | JavaScript, TypeScript and web development |
| Python | Python, pip, pytest, uv, Ruff | Automation, testing and Python development |
| Unity / C# | .NET SDK | C# development and external .NET tools for Unity projects |

### Activating an environment

From the repository directory:

```bash
nix develop
```

```bash
nix develop .#javascript
```

```bash
nix develop .#python
```

```bash
nix develop .#unity
```

You can also activate an environment from another directory by referencing the repository:

```bash
nix develop ~/wynn-nixos#python
```

To leave an environment:

```bash
exit
```

### Notes

- Development environments are defined in `flake.nix`.
- Their dependencies use the versions provided by the repository's locked `nixpkgs` input.
- Project-specific dependencies remain managed by their respective package managers.
- The Unity DevShell provides the .NET SDK, but does not install Unity Hub or Unity Editor.
- Unity projects may require specific editor and scripting runtime versions.

## Usage

### Requirements

- A working NixOS installation.
- Git.
- Nix Flakes enabled.
- Hardware configuration appropriate for the target machine.

Clone the repository and enter its directory:

```bash
git clone https://github.com/JuanWynn/wynn-nixos.git
cd wynn-nixos
```

### Validate the configuration

Check the Flake:

```bash
nix flake check
```

Format Nix files:

```bash
nix fmt
```

Build the system configuration without applying it:

```bash
sudo nixos-rebuild dry-build --flake .#nixos
```

### Apply the configuration

Only after a successful dry-build:

```bash
sudo nixos-rebuild switch --flake .#nixos
```

### Update Flake dependencies

Update the locked inputs:

```bash
nix flake update
```

Review the changes to `flake.lock` and validate the configuration before applying updates.

## Maintenance

The system includes declarative maintenance settings:

- Automatic weekly garbage collection.
- Removal of generations older than the configured retention period.
- Automatic Nix store optimization.
- Automatic filesystem trimming.
- ZRAM-based compressed swap.

These settings are managed through `modules/core/system.nix` and `modules/hardware/laptop.nix`.

## Roadmap

### Wynn Core — Backend

- [x] Establish the base NixOS configuration.
- [x] Introduce Nix Flakes and `flake.lock`.
- [x] Modularize system configuration.
- [x] Integrate Home Manager.
- [x] Configure PipeWire with ALSA and PulseAudio compatibility.
- [x] Configure hybrid AMD/NVIDIA graphics.
- [x] Configure NVIDIA PRIME render offload.
- [x] Integrate Steam and GameMode configuration.
- [x] Organize user applications and development tools.
- [x] Integrate Spicetify-Nix.
- [x] Develop reusable development environments.
- [x] Configure Syncthing synchronization.
- [x] Implement basic system maintenance and energy management.
- [ ] Verify GameMode operation.
- [ ] Review advanced PipeWire and JACK compatibility.
- [ ] Test suspend and resume.
- [ ] Improve CUDA support for creative and development workflows.
- [ ] Expand system monitoring and recovery documentation.
- [ ] Complete the NVMe migration.

### Wynn Desktop — Frontend

- [x] Install and configure Niri.
- [x] Integrate Noctalia.
- [x] Configure initial desktop shortcuts.
- [ ] Consolidate desktop shortcuts and workspaces.
- [ ] Develop Wynn visual identity and desktop theme.
- [ ] Implement desktop automation and profiles.
- [ ] Improve application integration.
- [ ] Organize portable desktop configuration and dotfiles.

---

Personal configuration maintained by Wynn.