
{
  programs.bash = {
    enable = true;

    historySize = 10000;
    historyFileSize = 20000;

    historyControl = [
      "ignoredups"
      "ignorespace"
    ];

    shellAliases = {
      ll = "ls -lah";
      ".." = "cd ..";
      "..." = "cd ../..";
    };
  };
}
