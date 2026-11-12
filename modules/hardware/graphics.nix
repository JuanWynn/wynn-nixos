{ ... }:

{
  # Graphics
  hardware.graphics.enable = true;

  # GPU drivers
  services.xserver.videoDrivers = [
    "amdgpu"
    "nvidia"
  ];

  # NVIDIA
  hardware.nvidia = {
    modesetting.enable = true;
    open = true;
    nvidiaSettings = true;

    # AMD + NVIDIA hybrid graphics
    prime = {
      offload.enable = true;
      offload.enableOffloadCmd = true;

      amdgpuBusId = "PCI:5@0:0:0";
      nvidiaBusId = "PCI:1@0:0:0";
    };
  };
}
