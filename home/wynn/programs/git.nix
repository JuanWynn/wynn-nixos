{ username, ... }:

{
  programs.git = {
    enable = true;

    signing = {
      format = "ssh";
      key = "/home/${username}/.ssh/id_ed25519.pub";
      signByDefault = true;
    };

    settings = {
      user = {
        name = "JuanWynn";
        email = "juannaranjo1411@gmail.com";
      };
    };
  };
}
