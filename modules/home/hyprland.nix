{
  pkgs,
  lib,
  config,
  inputs,
  ...
}: {
  options = {
    wms.hypr = {
      enable = lib.mkEnableOption "habilita Hyprlando a nível de sistema.";
    };
  };

  config = lib.mkIf config.wms.hypr.enable {
    wayland.windowManager.hyprland = {
      enable = true;
      package = inputs.hyprland.packages.${pkgs.system}.default;

      plugins = [];

      settings = {
        exec-once = [
        ];

        monitor = [
          ",preferred,auto,1"
        ];

        general = {
          layout = "dwindle";
          resize_on_border = true;
        };

        misc = {
          disable_splash_rendering = true;
          force_default_wallpaper = 1;
        };

        input = {
          kb_layout = "br";
          follow_mouse = 1;
          touchpad = {
            natural_scroll = "yes";
            disable_while_typing = true;
            drag_lock = true;
          };
          sensitivity = 0;
          float_switch_override_focus = 2;
        };

        dwindle = {
          pseudotile = "yes";
          preserve_split = "yes";
          # no_gaps_when_only = "yes";
        };

        gestures = {
          workspace_swipe = true;
          workspace_swipe_touch = true;
          workspace_swipe_use_r = true;
        };

        windowrule = let
          f = regex: "float, ^(${regex})$";
        in [
          (f "org.gnome.Calculator")
          (f "org.gnome.Nautilus")
          (f "pavucontrol")
          (f "nm-connection-editor")
          (f "blueberry.py")
          (f "org.gnome.Settings")
          (f "org.gnome.design.Palette")
          (f "Color Picker")
          (f "xdg-desktop-portal")
          (f "xdg-desktop-portal-gnome")
          (f "de.haeckerfelix.Fragments")
          "workspace 7, title:Spotify"
        ];

        decoration = {
          shadow = {
            range = 6;
            render_power = 2;
          };

          dim_inactive = false;

          blur = {
            enabled = true;
            size = 8;
            passes = 3;
            new_optimizations = "on";
            noise = 0.01;
            contrast = 0.9;
            brightness = 0.8;
            popups = true;
          };
        };

        animations = {
          enabled = "yes";
          bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
          animation = [
            "windows, 1, 5, myBezier"
            "windowsOut, 1, 7, default, popin 80%"
            "border, 1, 10, default"
            "fade, 1, 7, default"
            "workspaces, 1, 6, default"
          ];
        };

        "plugin:touch_gestures" = {
          sensitivity = 8.0;
          workspace_swipe_fingers = 3;
          long_press_delay = 400;
          edge_margin = 16;
          hyprgrass-bind = [
            ", edge:r:l, workspace, +1"
            ", edge:l:r, workspace, -1"
            ", edge:d:u, exec, marble toggle launcher"
          ];
        };

        # plugin = {
        #   overview = {
        #     centerAligned = true;
        #     hideTopLayers = true;
        #     hideOverlayLayers = true;
        #     showNewWorkspace = true;
        #     exitOnClick = true;
        #     exitOnSwitch = true;
        #     drawActiveWorkspace = true;
        #     reverseSwipe = true;
        #   };
        #
        #   hyprbars = {
        #     bar_color = "rgb(2a2a2a)";
        #     bar_height = 28;
        #     col_text = "rgba(ffffffdd)";
        #     bar_text_size = 11;
        #     bar_text_font = "Ubuntu Nerd Font";
        #
        #     buttons = {
        #       button_size = 0;
        #       "col.maximize" = "rgba(ffffff11)";
        #       "col.close" = "rgba(ff111133)";
        #     };
      };
    };
  };
}
