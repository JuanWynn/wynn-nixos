{ ... }:

let
  wynnSignalVesktopTheme = ''
    /**
     * @name WynnSignal
     * @author Wynn
     * @description WynnSignal colors and Space Grotesk typography.
     * @version 1.0.0
     */

    :root,
    .theme-dark {
      color-scheme: dark;

      --font-primary: "Space Grotesk", "gg sans", sans-serif;
      --font-display: "Space Grotesk", "gg sans", sans-serif;

      --brand-experiment: #FF6A00;
      --brand-experiment-500: #FF6A00;
      --brand-experiment-560: #E85F00;
      --brand-500: #FF6A00;

      --background-primary: #101116;
      --background-secondary: #1A1D26;
      --background-secondary-alt: #1D202A;
      --background-tertiary: #0B0C10;
      --background-floating: #181B23;
      --channeltextarea-background: #1C1F29;
      --background-modifier-hover: rgba(48, 55, 70, 0.52);
      --background-modifier-active: rgba(255, 106, 0, 0.16);
      --background-modifier-selected: rgba(22, 140, 255, 0.18);
      --background-modifier-accent: rgba(166, 169, 181, 0.12);

      --header-primary: #F4F1EA;
      --header-secondary: #A6A9B5;
      --text-normal: #F4F1EA;
      --text-muted: #A6A9B5;
      --text-link: #168CFF;
      --interactive-normal: #A6A9B5;
      --interactive-hover: #F4F1EA;
      --interactive-active: #FFFFFF;

      /* Discord's newer semantic color tokens. */
      --background-base-lowest: #0B0C10;
      --background-base-lower: #101116;
      --background-base-low: #181B23;
      --background-surface-high: #252936;
      --background-surface-higher: #303746;
      --text-default: #F4F1EA;
    }
  '';
in
{
  imports = [
    ./apps
    ./desktop/cursor.nix
    ./desktop/niri.nix
    ./desktop/noctalia.nix
    ./programs/alacritty.nix
    ./programs/git.nix
    ./programs/neovim-transparency.nix
    ./programs/spicetify.nix
    ./shell/bash.nix
  ];

  # Vencord uses its own config directory; Vesktop can also use its app-specific one.
  xdg.configFile."Vencord/themes/WynnSignal.theme.css".text = wynnSignalVesktopTheme;
  xdg.configFile."vesktop/themes/WynnSignal.theme.css".text = wynnSignalVesktopTheme;

  # User information
  home.username = "wynn";
  home.homeDirectory = "/home/wynn";

  # Home Manager state version
  home.stateVersion = "26.11";
}
