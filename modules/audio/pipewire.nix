
{ pkgs, ... }:

{
  # Disable standalone PulseAudio
  services.pulseaudio.enable = false;

  # Realtime audio permissions
  security.rtkit.enable = true;

  # PipeWire
  services.pipewire = {
    enable = true;

    alsa.enable = true;
    alsa.support32Bit = true;

    pulse.enable = true;

    # Avoid globally exporting JACK libraries
    jack.enable = false;
  };

  # JACK compatibility wrapper
  environment.systemPackages = [
    pkgs.pipewire.jack
  ];
}

