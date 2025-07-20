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
  wayland.windowManager.hyprland.settings =
    (rec {
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
    }
    // keybindings.keybindings
    // autostart.autostart
    // { extraConfig = rules; }
    // Add window/layer rules as extraConfig
    // This merges the rules.nix content as raw config lines
    // into the Hyprland config.
    // See: https://nix-community.github.io/home-manager/options.html#opt-wayland.windowManager.hyprland.extraConfig
    //
    // The curly braces below create an attrset to merge with the rest.
    // This is the idiomatic way to append extraConfig in Nix.
    //
    // If you want to add more raw config, just append to rules.nix.
    //
    { extraConfig = rules; }
    );
}
