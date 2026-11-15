{ inputs, pkgs, ... }:

let
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system};
in
{
  imports = [
    inputs.spicetify-nix.homeManagerModules.default
  ];

  programs.spicetify = {
    enable = true;

    theme = spicePkgs.themes.default // {
      name = "WynnSignal";
      additionalCss = ''
        :root {
          --encore-font-stack: "Space Grotesk", sans-serif;
          --encore-body-font-stack: "Space Grotesk", sans-serif;
          --encore-title-font-stack: "Space Grotesk", sans-serif;
        }

        body,
        button,
        input,
        textarea {
          font-family: "Space Grotesk", sans-serif !important;
        }
      '';
    };

    customColorScheme = {
      text = "F4F1EA";
      subtext = "A6A9B5";
      main = "101116";
      sidebar = "101116";
      player = "101116";
      card = "252936";
      shadow = "08090D";
      "selected-row" = "303746";
      button = "FF6A00";
      "button-active" = "FFC247";
      "button-disabled" = "414654";
      "tab-active" = "168CFF";
      notification = "252936";
      "notification-error" = "FF5268";
      misc = "101116";
    };
  };
}
