{ config, pkgs, ... }:

let
  styles = import ./styles.nix;

in {
  programs.kitty = {
    enable = true;
    font.name = styles.font;
    settings = {
      # The basic colors
      foreground = styles.foreground;
      background = styles.background;
      selection_foreground = styles.selection_foreground;
      selection_background = styles.selection_background;

      # Cursor colors
      cursor = styles.cursor;
      cursor_text_color = styles.cursor_text_color;

      # URL underline color when hovering with mouse
      url_color = styles.url_color;

      # Kitty window border colors
      active_border_color = styles.active_border_color;
      inactive_border_color = styles.inactive_border_color;
      bell_border_color = styles.bell_border_color;

      # OS Window titlebar colors
      wayland_titlebar_color = "system";
      macos_titlebar_color = "system";

      # Tab bar colors
      active_tab_foreground = styles.active_tab_foreground;
      active_tab_background = styles.active_tab_background;
      inactive_tab_foreground = styles.inactive_tab_foreground;
      inactive_tab_background = styles.inactive_tab_background;
      tab_bar_background = styles.tab_bar_background;

      # Colors for marks (marked text in the terminal)
      mark1_foreground = styles.mark1_foreground;
      mark1_background = styles.mark1_background;
      mark2_foreground = styles.mark2_foreground;
      mark2_background = styles.mark2_background;
      mark3_foreground = styles.mark3_foreground;
      mark3_background = styles.mark3_background;

      # The 16 terminal colors
      color0 = styles.color0;
      color1 = styles.color1;
      color2 = styles.color2;
      color3 = styles.color3;
      color4 = styles.color4;
      color5 = styles.color5;
      color6 = styles.color6;
      color7 = styles.color7;
      color8 = styles.color8;
      color9 = styles.color9;
      color10 = styles.color10;
      color11 = styles.color11;
      color12 = styles.color12;
      color13 = styles.color13;
      color14 = styles.color14;
      color15 = styles.color15;
    };
  };
}
