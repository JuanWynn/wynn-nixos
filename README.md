# Wynn NixOS

A personal, declarative NixOS system built around a Wayland desktop, development environments, creative applications, and gaming on hybrid AMD/NVIDIA hardware.

**Version:** 1.3 · **Status:** Active development

## System Overview

| Component | Configuration |
|---|---|
| Installed NixOS release | 26.11 |
| Nixpkgs channel | `nixos-unstable` (exact revision pinned in `flake.lock`) |
| Architecture | `x86_64-linux` |
| Host | ASUS TUF Gaming FX505DV |
| CPU | AMD Ryzen 7 3750H |
| Integrated graphics | AMD Radeon Vega 10 |
| Dedicated graphics | NVIDIA GeForce RTX 2060 Mobile 6 GB |
| Memory | 32 GB |
| Display protocol | Wayland |
| Compositor | Niri |
| Desktop shell | Noctalia |
| Terminal | Kitty |
| Login greeter | Noctalia Greeter through greetd |
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
│   ├── dev-environments.md
│   ├── desktop.md
│   ├── backup.md
│   ├── media-server.md
│   ├── profiles.md
│   └── recovery.md
├── examples/devshells/
│   ├── default/.envrc
│   ├── javascript/.envrc
│   ├── python/.envrc
│   └── unity/.envrc
├── hosts/nixos/
│   ├── default.nix
│   ├── hardware-configuration.nix
│   └── storage.nix
├── home/wynn/
│   ├── apps/default.nix
│   ├── desktop/
│   │   ├── cursor.nix
│   │   ├── niri.nix
│   │   ├── noctalia.nix
│   │   └── profiles/signal.nix
│   ├── programs/
│   │   ├── git.nix
│   │   ├── kitty.nix
│   │   ├── neovim-transparency.nix
│   │   └── spicetify.nix
│   ├── shell/bash.nix
│   └── default.nix
├── modules/
│   ├── backup/borgmatic.nix
│   ├── audio/pipewire.nix
│   ├── core/
│   │   ├── networking.nix
│   │   ├── system.nix
│   │   └── users.nix
│   ├── desktop/session.nix
│   ├── gaming/steam.nix
│   ├── profiles.nix
│   ├── services/syncthing.nix
│   ├── multimedia/
│   │   ├── compose.yaml
│   │   └── media-server.nix
│   └── hardware/
│       ├── graphics.nix
│       └── power.nix
├── .github/workflows/ci.yml
├── .pre-commit-config.yaml
├── .envrc
├── CHANGELOG.md
├── .sops.yaml
├── LICENSE
├── secrets/wynn.yaml
├── configuration.nix
├── flake.lock
└── flake.nix
```

## Wynn Core

The NixOS configuration is split into modules for core system settings, networking, users, hardware, the graphical session, audio, and gaming.

Implemented system features include:

- Nix Flakes with a locked dependency set and Home Manager integration.
- Niri, Noctalia Greeter through greetd, and XWayland support.
- A Plymouth `cybernetic` boot splash; systemd-boot remains the bootloader.
- AMD and NVIDIA graphics with NVIDIA PRIME offload.
- Bluetooth support through BlueZ, enabled at boot.
- NetworkManager using iwd as its Wi-Fi backend.
- PipeWire with ALSA, 32-bit ALSA, PulseAudio compatibility, RTKit, and the PipeWire JACK compatibility package.
- Optional `work` and `gaming` NixOS specialisations; see [`docs/profiles.md`](docs/profiles.md).
- Host-specific hardware, GPU identifiers, and filesystem UUIDs grouped under `hosts/nixos/`.
- Direnv with nix-direnv integration for Flake development shells; see [`docs/dev-environments.md`](docs/dev-environments.md).
- Steam, Steam hardware support, and GameMode.
- Syncthing service for device synchronization.
- A rootless Podman media stack that starts manually; see [`docs/media-server.md`](docs/media-server.md).
- A data volume declared as ext4 and mounted at `/mnt/data`.
- SOPS and age for the encrypted user password hash.

### Development shells

The Flake provides these shells:

| Shell | Main tools |
|---|---|
| `default` | Git, Nix formatter, Nil, Statix |
| `javascript` | Node.js, pnpm |
| `python` | Python, uv, pytest, Ruff |
| `unity` | .NET SDK |

The root `.envrc` selects the default shell. Example selectors for all four
shells are in `examples/devshells/`.

Node.js and pnpm are provided by the `javascript` shell; Nixfmt, Nil, and Statix are provided by the `default` shell rather than installed persistently in the user profile. Enter a shell with `nix develop` or select one by name, for example `nix develop .#python`.

## Wynn Desktop

Niri and Noctalia are managed declaratively through Home Manager. The desktop currently includes:

- Five named activity workspaces and the existing Niri keybindings and window rules.
- The Noctalia `WynnSignal` dark palette, using orange, blue, and yellow accents.
- Noctalia's panel, dock, launcher, control center, blur, transparency, and animations; the session lock screen engages after ten minutes of inactivity.
- Niri compositor blur for Kitty and Noctalia's bar and dock; Kitty opacity is configured through Home Manager.
- Neovim transparency highlights configured through a Home Manager-managed Lua file.
- Space Grotesk installed system-wide and used by Noctalia, Spicetify, and the WynnSignal Vencord theme.
- Bibata Modern Ice cursors at size 24, configured through Home Manager and Niri.
- Noctalia's built-in screenshot and annotation features, tested and kept as configured.
- User-managed wallpaper selection.

The desktop overview and current shortcut reference are in [`docs/desktop.md`](docs/desktop.md). The Niri configuration is in [`config/niri/config.kdl`](config/niri/config.kdl), and Noctalia's WynnSignal profile is in [`home/wynn/desktop/profiles/signal.nix`](home/wynn/desktop/profiles/signal.nix).

## User Applications

Applications are declared in Home Manager, except Firefox, which is enabled at the NixOS level.

- **Development:** VS Code, Neovim, Nano, GitKraken.
- **System utilities:** tree, wget, Fastfetch, pciutils, Mesa demos, btop, ripgrep, fd, fzf, jq, playerctl, brightnessctl.
- **Desktop and files:** Kitty, Dolphin, Ark, Okular, Gwenview, Yazi, YACReader.
- **Office:** LibreOffice.
- **Multimedia and creative:** VLC, Blender, GIMP, Inkscape, OBS Studio, FFmpeg, ImageMagick.
- **Gaming:** Steam; RetroArch cores for NES, SNES, N64, PS1, PS2, PSP, Game Boy, Game Boy Color, Game Boy Advance, Nintendo DS, 3DS, and GameCube; Vita3K for PS Vita.
- **Communication:** Vesktop, with Vencord built in.
- **Audio tools:** qpwgraph and the PulseAudio package; PipeWire provides PulseAudio compatibility.
- **Compression:** unzip, zip, p7zip.
- **Music:** Spotify installed and customized declaratively through Spicetify-Nix.

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

# Evaluate the NixOS configuration and check definitions without building outputs
nix flake check --no-build

# Build and run the Flake checks, including Niri configuration validation
nix flake check

# Update locked inputs
nix flake update
```

## Secrets and Recovery

The repository contains the encrypted SOPS file and its encryption rules. The age private key is stored outside the repository and must be backed up separately. Never commit or upload that private key. See [`docs/recovery.md`](docs/recovery.md) for the recovery procedure.

Git is configured to sign commits and tags with SSH using
`~/.ssh/id_ed25519.pub`. A key must be created locally and added to GitHub as
a signing key before relying on automatic signing; see
[`docs/dev-environments.md`](docs/dev-environments.md). The local hooks are
configured in `.pre-commit-config.yaml`; install them with `pre-commit install`.

## Backups

The Borgmatic configuration is prepared but disabled. It will back up the home directory, this repository, `/mnt/data`, and `/etc/nixos`, excluding caches, downloads, Steam libraries, DaVinci Resolve cache/proxy folders, and age private keys. When enabled, it will run daily, retain 7 daily, 4 weekly, and 6 monthly snapshots, and report failures to the system journal and logged-in terminals. The repository passphrase is configured through SOPS; it is never stored in the Nix configuration.

The USB checked for this purpose was a 3.7 GB FAT volume labelled `ARCH_202605`. It is too small for the data set and FAT is not recommended for a Borg repository, so it was left untouched and will not be used. Backups remain disabled until a suitable larger external disk or remote repository is chosen. See [`docs/backup.md`](docs/backup.md) for the future setup and restore procedure.

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
- [x] Declare the media and brightness utilities used by Niri keybindings and add Flake checks for NixOS evaluation and Niri syntax.

### In progress or planned

- [ ] Develop useful on-demand desktop workflows and profiles.
- [ ] Explore application integrations and mobile file synchronization when a concrete workflow is selected.
- [ ] Add system maintenance and observability tools where they solve a demonstrated need.
- [ ] Evaluate CUDA support for specific creative or development applications.
- [ ] Improve documentation and portability for other machines.

Personal configuration maintained by Wynn.
