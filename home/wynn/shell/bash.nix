
{
  programs.bash = {
    enable = true;

    historySize = 10000;
    historyFileSize = 20000;

    historyControl = [
      "ignoredups"
      "ignorespace"
    ];

    bashrcExtra = ''
      shopt -s histappend
      shopt -s extglob
      shopt -s globstar
      shopt -s checkjobs
    '';

    shellAliases = {
      ll = "ls -lah";
      ".." = "cd ..";
      "..." = "cd ../..";
    };
  };
}
