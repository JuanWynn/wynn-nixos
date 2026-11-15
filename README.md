# Wynn NixOS

A personal, declarative NixOS system built around a Wayland desktop, development environments, creative applications, and gaming on hybrid AMD/NVIDIA hardware.

**Version:** 1.3 · **Status:** Active development

## System Overview

| Component | Configuration |
|---|---|
| Operating system | NixOS 26.11 |
| Architecture | `x86_64-linux` |
| Host | ASUS TUF Gaming FX505DV |
| CPU | AMD Ryzen 7 3750H |
| Integrated graphics | AMD Radeon Vega 10 |
| Dedicated graphics | NVIDIA GeForce RTX 2060 Mobile 6 GB |
| Memory | 32 GB |
| Display protocol | Wayland |
| Compositor | Niri |
| Desktop shell | Noctalia |
| Terminal | Alacritty |
| Login manager | greetd |
| Network | NetworkManager with iwd |
| Audio | PipeWire |
| System and user configuration | Nix Flakes and Home Manager |
| Secrets | SOPS and age |

## Project Structure

Wynn NixOS has two coordinated layers:

- **Wynn Core** manages NixOS, hardware, services, networking, audio, gaming, and development environments.
- **Wynn Desktop** manages Niri, Noctalia, user applications, visual configuration, and desktop integrations.

```text
wynn-nixos/
├── config/
│   └── niri/config.kdl
├── docs/
│   ├── desktop.md
│   └── recovery.md
├── home/wynn/
│   ├── apps/default.nix
│   ├── desktop/
│   │   ├── cursor.nix
│   │   ├── niri.nix
│   │   ├── noctalia.nix
│   │   └── profiles/signal.nix
│   ├── programs/
│   │   ├── git.nix
│   │   └── spicetify.nix
│   ├── shell/bash.nix
│   └── default.nix
├── modules/
│   ├── audio/pipewire.nix
│   ├── core/
│   │   ├── networking.nix
│   │   ├── system.nix
│   │   └── users.nix
│   ├── desktop/session.nix
│   ├── gaming/steam.nix
│   └── hardware/
│       ├── graphics.nix
│       └── storage.nix
├── .sops.yaml
├── secrets/wynn.yaml
├── configuration.nix
├── flake.lock
├── flake.nix
└── hardware-configuration.nix
```

## Wynn Core

The NixOS configuration is split into modules for core system settings, networking, users, hardware, the graphical session, audio, and gaming.

Implemented system features include:

- Nix Flakes with a locked dependency set and Home Manager integration.
- Niri, greetd, and XWayland support.
- AMD and NVIDIA graphics with NVIDIA PRIME offload.
- NetworkManager using iwd as its Wi-Fi backend.
- PipeWire with ALSA, 32-bit ALSA, PulseAudio compatibility, RTKit, and the PipeWire JACK compatibility package.
- Steam, Steam hardware support, and GameMode.
- An NTFS data volume mounted at `/mnt/data`.
- SOPS and age for the encrypted user password hash.

### Development shells

The Flake provides these shells:

| Shell | Main tools |
|---|---|
| `default` | Git, Nix formatter, Nil, Statix |
| `javascript` | Node.js, pnpm |
| `python` | Python, uv, pytest, Ruff |
| `unity` | .NET SDK |

Enter a shell with `nix develop` or select one by name, for example `nix develop .#python`.

## Wynn Desktop

Niri and Noctalia are managed declaratively through Home Manager. The desktop currently includes:

- Five named activity workspaces and the existing Niri keybindings and window rules.
- The Noctalia `WynnSignal` dark palette, using orange, blue, and yellow accents.
- Noctalia's panel, dock, launcher, control center, lockscreen, blur, transparency, and animations.
- Space Grotesk as the Noctalia shell font.
- Bibata Modern Ice cursors at size 24, configured through Home Manager and Niri.
- Noctalia's built-in screenshot and annotation features, tested and kept as configured.
- User-managed wallpaper selection.

The desktop overview and current shortcut reference are in [`docs/desktop.md`](docs/desktop.md). The Niri configuration is in [`config/niri/config.kdl`](config/niri/config.kdl), and Noctalia's WynnSignal profile is in [`home/wynn/desktop/profiles/signal.nix`](home/wynn/desktop/profiles/signal.nix).

## User Applications

Applications are declared in Home Manager, except Firefox, which is enabled at the NixOS level.

- **Development:** VS Code, Neovim, Vim, Nano, GitKraken, Node.js, pnpm, Nix formatter, Nil, Statix.
- **System utilities:** tree, wget, Fastfetch, pciutils, Mesa demos, btop, ripgrep, fd, fzf, jq.
- **Desktop and files:** Alacritty, Dolphin, Ark, Okular, Gwenview, Yazi, YACReader.
- **Office:** LibreOffice.
- **Multimedia and creative:** VLC, Blender, GIMP, Inkscape, OBS Studio, FFmpeg, ImageMagick.
- **Communication:** Discord.
- **Audio tools:** qpwgraph and the PulseAudio package; PipeWire provides PulseAudio compatibility.
- **Compression:** unzip, zip, p7zip.
- **Music:** Spotify customization through Spicetify-Nix.

## Common Commands

Run from the repository root:

```bash
# Check whether the system configuration evaluates and builds
sudo nixos-rebuild dry-build --flake .#nixos

# Apply the system and Home Manager configuration
sudo nixos-rebuild switch --flake .#nixos

# Enter a development shell
nix develop
nix develop .#javascript
nix develop .#python
nix develop .#unity

# Format the Flake outputs
nix fmt

# Evaluate Flake checks without building their outputs
nix flake check --no-build

# Update locked inputs
nix flake update
```

## Secrets and Recovery

The repository contains the encrypted SOPS file and its encryption rules. The age private key is stored outside the repository and must be backed up separately. Never commit or upload that private key. See [`docs/recovery.md`](docs/recovery.md) for the recovery procedure.

## Roadmap

### Completed

- [x] Establish the Flake-based NixOS configuration and integrate Home Manager.
- [x] Modularize system, hardware, desktop, audio, and gaming configuration.
- [x] Configure Niri and Noctalia, including five named workspaces, keybindings, and window rules.
- [x] Configure hybrid AMD/NVIDIA graphics and PRIME offload.
- [x] Configure PipeWire, Steam, GameMode, SOPS, and Spicetify-Nix.
- [x] Add reusable default, JavaScript, Python, and Unity development shells.
- [x] Apply a Flake-based system switch.
- [x] Establish the WynnSignal desktop palette and configure Bibata Modern Ice cursors.
- [x] Try Noctalia's built-in screenshot features and keep the current setup.

### In progress or planned

- [ ] Develop useful on-demand desktop workflows and profiles.
- [ ] Explore application integrations and mobile file synchronization when a concrete workflow is selected.
- [ ] Add system maintenance and observability tools where they solve a demonstrated need.
- [ ] Evaluate CUDA support for specific creative or development applications.
- [ ] Improve documentation and portability for other machines.

Personal configuration maintained by Wynn.
