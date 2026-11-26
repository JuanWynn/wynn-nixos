{ config, username, ... }:

{
  users.mutableUsers = true;

  # User password secret
  sops.secrets."wynn-password-hash" = {
    sopsFile = ../../secrets/wynn.yaml;
    neededForUsers = true;
  };

  # User account
  users.users.${username} = {
    isNormalUser = true;

    hashedPasswordFile = config.sops.secrets."wynn-password-hash".path;

    extraGroups = [
      "wheel"
      "gamemode"
    ];
  };
}
