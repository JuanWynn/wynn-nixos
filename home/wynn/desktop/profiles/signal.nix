_:

{
  programs.noctalia = {
    settings = {
      theme = {
        mode = "dark";
        source = "custom";
        custom_palette = "WynnSignal";
        shell_mode = "follow";
        sync_color_scheme = true;
      };

      panel = {
        launcher_placement = "floating";
        launcher_position = "bottom_center";
        floating_offset = 16;
      };

      backdrop = {
        enabled = true;
        blur_intensity = 0.65;
        tint_intensity = 0.25;
      };

      bar = {
        order = [ "default" ];

        default = {
          enabled = true;
          auto_hide = true;
          auto_hide_delay_ms = 300;
          reserve_space = true;
          auto_hide_reserve_space = true;
          position = "left";
          thickness = 52;
          margin_ends = 100;
          margin_edge = 8;
          background_opacity = 0.78;
          compositor_blur = true;
          radius = 16;
          padding = 10;
          widget_spacing = 8;

          start = [
            "launcher"
            "workspaces"
          ];
          center = [ ];
          end = [
            "media"
            "notifications"
            "network"
            "volume"
            "brightness"
            "battery"
            "control-center"
            "session"
          ];
        };
      };

      dock = {
        enabled = true;
        position = "bottom";
        auto_hide = true;
        auto_hide_delay_ms = 300;
        background_opacity = 0.82;
        compositor_blur = true;
        icon_size = 48;
        magnification = true;
        magnification_scale = 1.35;
        radius = 16;
        margin_edge = 8;
        show_running = true;
        show_dots = true;
        reserve_space = false;
      };

      shell = {
        font_family = "Space Grotesk";
        settings_window_translucent = true;
        animation.enabled = true;
        animation.speed = 1.0;
        panel.transparency_mode = "blur";

        launcher = {
          layout = "simple";
          categories = false;
          compact = true;
        };
      };

      lockscreen = {
        enabled = true;
        blur_intensity = 0.65;
        tint_intensity = 0.25;
      };

      lockscreen_widgets.enabled = false;

      idle.behavior.lock = {
        enabled = true;
        timeout = 600;
        action = "lock";
      };

      wallpaper = {
        enabled = true;
        fill_mode = "crop";
        transition_duration = 1500;
      };
    };

    customPalettes.WynnSignal.dark = {
      mPrimary = "#FF6A00";
      mOnPrimary = "#101116";
      mSecondary = "#168CFF";
      mOnSecondary = "#FFFFFF";
      mTertiary = "#FFC247";
      mOnTertiary = "#101116";
      mError = "#FF5268";
      mOnError = "#101116";
      mSurface = "#101116";
      mOnSurface = "#F4F1EA";
      mSurfaceVariant = "#252936";
      mOnSurfaceVariant = "#A6A9B5";
      mOutline = "#414654";
      mShadow = "#08090D";
      mHover = "#303746";
      mOnHover = "#F4F1EA";
    };
  };
}
