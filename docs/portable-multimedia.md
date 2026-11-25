# Laptop power and multimedia

The laptop uses AMD/NVIDIA PRIME offload. The NVIDIA power management options
are enabled for the RTX 2060; the NVIDIA GPU should still remain available for
CUDA workloads and explicit offload.

## Power management

`power-profiles-daemon` manages the system power profiles. `asusd` is enabled
for ASUS hardware controls, with its platform-profile and EPP changes disabled
to avoid competing with PPD. Available controls depend on the firmware and the
FX505DV hardware support in the running kernel.

After switching to this generation, check:

```sh
powerprofilesctl
systemctl status power-profiles-daemon asusd
cat /sys/firmware/acpi/platform_profile
```

Check idle power draw on battery after the machine has settled, with the NVIDIA
GPU idle. `nvidia-smi` can confirm whether a process is keeping the GPU awake.
Compare the result with the prior generation under similar brightness and
workload conditions.

## NVIDIA and Blender

Launch an application with `nvidia-offload <command>` to exercise PRIME
offload. For example:

```sh
nvidia-offload glxinfo -B
nvidia-smi
```

Blender is already built with CUDA support in the Home Manager package
configuration. In Blender, select CUDA in Preferences > System, choose the
RTX 2060 for rendering, and run a small Cycles render. Check `nvidia-smi`
during the render. The configured Nix caches include the current CUDA cache
and Noctalia cache; Noctalia is pinned to its own nixpkgs input in the flake.

## Disk, memory, and color

The system enables zram swap, periodic SSD discard (`fstrim`), automatic Nix
store optimization, SMART monitoring, and `colord`.

To use a monitor ICC profile, import the profile and associate it with the
display in the desktop's color settings. On systems without a color settings
panel, inspect the detected devices with `colormgr get-devices`, import a
profile with `colormgr import-profile /path/to/profile.icc`, then associate it
using `colormgr device-add-profile DEVICE_ID PROFILE_ID`.

## Optional low-latency audio

PipeWire retains its current defaults for compatibility with normal playback
and Steam. To try the optional lower-latency settings, add this to the NixOS
configuration:

```nix
services.pipewire.lowLatency.enable = true;
```

This selects 48 kHz with a 256-frame default quantum and permits a minimum of
128 frames. Smaller buffers can cause crackling under load; listen for audio
dropouts and turn the option back off if they occur.
