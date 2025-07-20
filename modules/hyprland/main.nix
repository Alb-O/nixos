# main.nix
{ config, pkgs, ... }:
let
  keybindings = import ./keybindings.nix;
  autostart = import ./autostart.nix;
  rules = builtins.readFile ./rules.nix;
in
{
  wayland.windowManager.hyprland.enable = true;
  wayland.windowManager.hyprland.systemd.enable = false;
  wayland.windowManager.hyprland.settings = rec {
    general = {
      gaps_in = 5;
      gaps_out = 15;
      border_size = 2;
      "col.active_border" = "rgba(dbbfefee)";
      "col.inactive_border" = "rgba(59595900)";
    };
    input = {
      kb_options = "caps:swapescape";
    };
    animations = {
      enabled = "no";
    };
    misc = {
      force_default_wallpaper = 0;
      disable_hyprland_logo = true;
      middle_click_paste = false;
    };
    decoration = {
      shadow = {
        enabled = false;
      };
      blur = {
        enabled = false;
      };
    };
    gestures = {
      workspace_swipe = true;
    };
    # Merge in keybindings and autostart
    "$mod" = keybindings.keybindings."$mod";
    bind = keybindings.keybindings.bind;
    bindm = keybindings.keybindings.bindm;
    "exec-once" = autostart.autostart."exec-once";
    workspace = autostart.autostart.workspace;
    windowrule = autostart.autostart.windowrule;
  };
  wayland.windowManager.hyprland.extraConfig = rules;
}
