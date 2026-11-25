{ pkgs, ... }:

{
  xdg.configFile."niri/config.kdl".text =
    builtins.replaceStrings
      [ "@POLKIT_AGENT@" ]
      [ "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1" ]
      (builtins.readFile ../../../config/niri/config.kdl);
}
