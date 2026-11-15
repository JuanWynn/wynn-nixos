# Wynn Desktop — Niri & Noctalia

## Overview

Wynn Desktop uses Niri as its Wayland compositor and Noctalia as its desktop shell.

The configuration is managed declaratively through Home Manager and stored in the main Wynn NixOS repository.

| Component | Software |
|---|---|
| Window Manager | Niri |
| Desktop Shell | Noctalia |
| Display Protocol | Wayland |
| Terminal | Alacritty |
| Application Launcher | Noctalia |
| File Manager | Dolphin |
| Browser | Firefox |

## Configuration Files

| File | Purpose |
|---|---|
| `config/niri/config.kdl` | Niri configuration |
| `home/wynn/desktop/niri.nix` | Home Manager integration |
| `home/wynn/default.nix` | Home Manager imports and local Vesktop/Vencord theme |
| `home/wynn/desktop/profiles/signal.nix` | Noctalia WynnSignal settings and palette |
| `home/wynn/programs/alacritty.nix` | Alacritty opacity and Home Manager integration |
| `home/wynn/programs/neovim-transparency.nix` | Neovim transparent highlight groups |
| `home/wynn/programs/spicetify.nix` | Spotify WynnSignal palette and Space Grotesk styling |

Niri configuration is linked declaratively through Home Manager.

## Workspace Organization

The desktop uses five named workspaces organized by activity.

| Workspace | Name | Applications |
|---|---|---|
| 1 | CONTROL CENTER | Alacritty (startup instance) |
| 2 | GENERAL | Dolphin, Vesktop, Spotify (managed by Spicetify-Nix) |
| 3 | DEVELOPMENT | Visual Studio Code, GitKraken |
| 4 | MULTIMEDIA | Blender, DaVinci Resolve, and multimedia tools |
| 5 | GAMING | Steam and games |
| 6–9 | Available | No predefined assignments |

Firefox and manually opened Alacritty terminals are not assigned to a fixed workspace.

## Quick Keyboard Shortcuts

`Mod` corresponds to the Super key (Windows key).

### Applications

| Shortcut | Action |
|---|---|
| `Mod + T` | Open Alacritty |
| `Mod + B` | Open Firefox |
| `Mod + Y` | Open Dolphin |
| `Mod + G` | Open GitKraken |
| `Mod + X` | Open Visual Studio Code |
| `Mod + Shift + S` | Open Steam |

### Noctalia

| Shortcut | Action |
|---|---|
| `Mod + Space` | Toggle application launcher |
| `Mod + S` | Toggle control center |
| `Mod + Alt + L` | Lock screen |

### Workspace Navigation

| Shortcut | Action |
|---|---|
| `Mod + 1` to `Mod + 9` | Focus workspace 1–9 |
| `Mod + Ctrl + 1` to `Mod + Ctrl + 9` | Move current column to workspace 1–9 |
| `Mod + Page Down` | Focus next workspace |
| `Mod + Page Up` | Focus previous workspace |
| `Mod + U` | Focus next workspace |
| `Mod + I` | Focus previous workspace |
| `Mod + Ctrl + Page Down` | Move column to next workspace |
| `Mod + Ctrl + Page Up` | Move column to previous workspace |

### Audio and Media

| Control | Action |
|---|---|
| `wpctl` | Audio volume and microphone controls |
| `playerctl` | Media playback controls |
| `brightnessctl` | Screen brightness controls |

The audio, media and brightness controls are configured through dedicated Niri keybindings.
The `playerctl` and `brightnessctl` commands are included in the Home Manager package set.

Noctalia Greeter through greetd requests the account password before starting Niri. Its dark login screen uses the Wynn orange, blue, and yellow palette with Space Grotesk. Noctalia's in-session lock screen and its widgets are disabled. The firmware and systemd-boot menu appear before Plymouth; the splash covers the operating-system loading phase.

## Window Rules

Applications are automatically assigned to workspaces through Niri `window-rule` declarations.

| Application | App ID | Workspace |
|---|---|---|
| Dolphin | `org.kde.dolphin` | GENERAL |
| Vesktop | `(?i)^vesktop$` | GENERAL |
| Visual Studio Code | `code` | DEVELOPMENT |
| GitKraken | `gitkraken` | DEVELOPMENT |
| Steam | `steam` | GAMING |
| DaVinci Resolve | `(?i)^davinci-resolve(-nvidia)?$` | MULTIMEDIA |

These rules apply when new application windows are created. Existing windows may need to be reopened to use the updated assignments.

## Startup Applications

Niri starts one Alacritty instance automatically.

```kdl
spawn-at-startup "alacritty"
```

This instance provides a persistent terminal in CONTROL CENTER.

Other Alacritty instances remain unrestricted and can be opened in any workspace.

Noctalia is managed independently through its systemd service. No additional startup applications are currently configured.

Alacritty's opacity is configured through Home Manager, with Niri applying a compositor blur effect. Noctalia's bar and dock request compositor blur through their WynnSignal settings; Niri's layer rule uses content behind those surfaces. These settings are declared in the repository; apply them with a system rebuild and check the running session to confirm runtime behavior.

Space Grotesk is installed system-wide from a pinned Google Fonts revision. Noctalia, Spicetify, and the local Vencord theme use the same font with the WynnSignal orange, blue, yellow, and dark-surface palette. After rebuilding, enable **WynnSignal** once in Vesktop under **Settings → Vencord → Themes**.

GParted is installed system-wide for graphical disk partitioning. DaVinci Resolve (free edition) is installed in the user package set and launches through `davinci-resolve-nvidia`, which selects the NVIDIA GPU with PRIME offload and uses XWayland compatibility for the current Niri session. This requires the NVIDIA GPU and driver to support CUDA. The free Linux edition has limited H.264/H.265 and AAC support.

## Validation and Updates

Validate the Niri configuration:

```bash
niri validate
```

Evaluate the NixOS configuration and the Flake check definitions without building:

```bash
nix flake check --no-build
```

Build the checks, including Niri's syntax validation:

```bash
nix flake check
```

Apply system and Home Manager changes:

```bash
sudo nixos-rebuild switch --flake /home/wynn-nixos#nixos
```

Niri configuration changes can be validated before applying them to the system.

## Design Principles

- Keep startup processes minimal.
- Organize workspaces by activity.
- Use automatic window rules only where useful.
- Keep browser and terminal usage flexible.
- Manage desktop configuration declaratively.
- Avoid unnecessary background services.
