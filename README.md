# Wynn NixOS

Personal NixOS desktop configuration designed around a Wayland-first workflow, creative applications, development tools, gaming, and a hybrid AMD/NVIDIA graphics setup.

**Version:** 1.2  
**Status:** Active development

## System Overview

| Component | Configuration |
|---|---|
| Operating System | NixOS 26.11 |
| Architecture | x86_64-linux |
| Desktop Environment | Niri |
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
- **Storage:** 2 TB SSD + 500 GB SSD

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
- Nix development tools (nixfmt, nil, statix)

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

- Declarative system configuration using NixOS.
- Flake-based configuration with locked dependencies.
- Modular system architecture.
- Home Manager integration for user-level configuration and applications.
- Niri Wayland compositor.
- Noctalia desktop shell.
- Hybrid AMD/NVIDIA graphics configuration.
- NVIDIA PRIME render offload.
- XWayland compatibility for applications requiring X11.
- PipeWire audio stack with ALSA, PulseAudio compatibility and JACK support through PipeWire.
- Steam and GameMode integration.
- Persistent NTFS data partition mounted at `/mnt/data`.
- Declarative Spotify customization through Spicetify-Nix.
- Reusable development environments through Nix DevShells.

## Repository Structure

```text
wynn-nixos/
├── flake.nix
├── flake.lock
├── configuration.nix
├── modules/
│   ├── audio/
│   ├── core/
│   └── gaming/
└── home/
    └── wynn/
        ├── apps/
        ├── desktop/
        ├── programs/
        └── shell/
```

The repository separates system-level configuration from user-level configuration.

- **NixOS Modules:** hardware, system services, audio, users and gaming.
- **Home Manager:** user applications, programs, shell configuration and desktop-related settings.
- **Flakes:** dependency management and reproducible system configuration.

## Development Environments

Wynn NixOS provides reusable development environments through Nix Flakes.

Each DevShell declares its own tools and dependencies without requiring additional global system packages.

### Available environments

| Environment | Tools | Intended use |
|---|---|---|
| JavaScript | Node.js, pnpm | JavaScript, TypeScript and web development |
| Python | Python, pip, pytest, Ruff | Data analysis, automation and Python development |
| Unity / C# | .NET SDK | C# development and external .NET tools for Unity projects |

### Activating an environment

From the repository directory:

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

Clone the repository and enter its directory:

```bash
git clone https://github.com/JuanWynn/wynn-nixos.git
cd wynn-nixos
```

Validate the configuration before applying changes:

```bash
sudo nixos-rebuild dry-build --flake .#nixos
```

Apply the configuration:

```bash
sudo nixos-rebuild switch --flake .#nixos
```

Update Flake dependencies:

```bash
nix flake update
```

Check the Flake:

```bash
nix flake check
```

## Roadmap

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
- [x] Develop reusable development environments (DevShells).
- [ ] Improve CUDA support for creative and development workflows.
- [ ] Implement optional device synchronization.
- [ ] Introduce maintenance and system monitoring tools.
- [ ] Refine desktop appearance and visual identity.

---

Personal configuration maintained by Wynn.