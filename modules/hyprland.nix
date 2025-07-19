# /home/albert/.config/nixos/modules/hyprland.nix
{ config, pkgs, ... }:

{
  wayland.windowManager.hyprland.enable = true;
  wayland.windowManager.hyprland.settings = {
    "general" = {
      gaps_in = 5;
      gaps_out = 15;
      border_size = 2;
      "col.active_border" = "rgba(dbbfefee)";
      "col.inactive_border" = "rgba(59595900)";
    };
    "input" = {
      kb_options = "caps:swapescape";
    };
    "$mod" = "SUPER";
    "bind" = [
      # Applications
      "$mod, Return, exec, kitty"
      "$mod, D, exec, fuzzel"

      # Window Management
      "$mod, Q, killactive,"
      "$mod, F, fullscreen"
      "$mod, T, togglefloating"

      # Focus
      "$mod, left, movefocus, l"
      "$mod, right, movefocus, r"
      "$mod, up, movefocus, u"
      "$mod, down, movefocus, d"

      # Workspaces
      "$mod, 1, workspace, 1"
      "$mod, 2, workspace, 2"
      "$mod, 3, workspace, 3"
      "$mod, 4, workspace, 4"
      "$mod, 5, workspace, 5"
      "$mod, 6, workspace, 6"
      "$mod, 7, workspace, 7"
      "$mod, 8, workspace, 8"
      "$mod, 9, workspace, 9"
      "$mod, 0, workspace, 10"

      # Move to workspace
      "$mod SHIFT, 1, movetoworkspace, 1"
      "$mod SHIFT, 2, movetoworkspace, 2"
      "$mod SHIFT, 3, movetoworkspace, 3"
      "$mod SHIFT, 4, movetoworkspace, 4"
      "$mod SHIFT, 5, movetoworkspace, 5"
      "$mod SHIFT, 6, movetoworkspace, 6"
      "$mod SHIFT, 7, movetoworkspace, 7"
      "$mod SHIFT, 8, movetoworkspace, 8"
      "$mod SHIFT, 9, movetoworkspace, 9"
      "$mod SHIFT, 0, movetoworkspace, 10"

      # Exit
      "$mod, M, exit,"
    ];
    "bindm" = [
      "$mod, mouse:272, movewindow"
      "$mod, mouse:273, resizewindow"
    ];
    "animations" = {
      enabled = "no";
    };
    "misc" = {
      force_default_wallpaper = 0;
      disable_hyprland_logo = true;
      middle_click_paste = false;
    };
    "decoration" = {
      shadow = {
        enabled = false;
      };
      blur = {
        enabled = false;
      };
    };
    "gestures" = {
      workspace_swipe = true;
    };
    "exec-once" = [
      "1password-gui --silent"
      "swww init"
      "swww-daemon"
      "swww clear '#3b224c'"
    ];
    "workspace" = [
      "w[tv1], gapsout:0, gapsin:0"
      "f[1], gapsout:0, gapsin:0"
    ];
    "windowrule" = [
      "bordersize 0, floating:0, onworkspace:w[tv1]"
      "rounding 0, floating:0, onworkspace:w[tv1]"
      "bordersize 0, floating:0, onworkspace:f[1]"
      "rounding 0, floating:0, onworkspace:f[1]"
    ];
  };
}
