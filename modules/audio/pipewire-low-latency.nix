{ config, lib, ... }:

let
  cfg = config.services.pipewire.lowLatency;
in
{
  options.services.pipewire.lowLatency.enable = lib.mkEnableOption "low-latency PipeWire settings";

  config = lib.mkIf cfg.enable {
    services.pipewire.extraConfig.pipewire."92-low-latency" = {
      "context.properties" = {
        "default.clock.rate" = 48000;
        "default.clock.quantum" = 256;
        "default.clock.min-quantum" = 128;
        "default.clock.max-quantum" = 256;
      };
    };
  };
}
