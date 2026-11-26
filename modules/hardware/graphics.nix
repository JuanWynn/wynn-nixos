_:

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
    powerManagement = {
      enable = true;
      finegrained = true;
    };

    # AMD + NVIDIA hybrid graphics
    prime = {
      offload.enable = true;
      offload.enableOffloadCmd = true;
    };
  };
}
