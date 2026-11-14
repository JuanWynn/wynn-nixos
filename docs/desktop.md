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
| `home/wynn/default.nix` | Home Manager imports |

Niri configuration is linked declaratively through Home Manager.

## Workspace Organization

The desktop uses five named workspaces organized by activity.

| Workspace | Name | Applications |
|---|---|---|
| 1 | CONTROL CENTER | Alacritty (startup instance) |
| 2 | GENERAL | Dolphin, Discord, Spotify |
| 3 | DEVELOPMENT | Visual Studio Code, GitKraken |
| 4 | MULTIMEDIA | Blender and multimedia tools |
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

## Window Rules

Applications are automatically assigned to workspaces through Niri `window-rule` declarations.

| Application | App ID | Workspace |
|---|---|---|
| Dolphin | `org.kde.dolphin` | GENERAL |
| Discord | `discord` | GENERAL |
| Visual Studio Code | `code` | DEVELOPMENT |
| GitKraken | `gitkraken` | DEVELOPMENT |
| Steam | `steam` | GAMING |

These rules apply when new application windows are created. Existing windows may need to be reopened to use the updated assignments.

## Startup Applications

Niri starts one Alacritty instance automatically.

```kdl
spawn-at-startup "alacritty"
```

This instance provides a persistent terminal in CONTROL CENTER.

Other Alacritty instances remain unrestricted and can be opened in any workspace.

Noctalia is managed independently through its systemd service. No additional startup applications are currently configured.

## Validation and Updates

Validate the Niri configuration:

```bash
niri validate
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