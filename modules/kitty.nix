{ config, pkgs, ... }:

{
  programs.kitty = {
    enable = true;
    font.name = "JetBrainsMono Nerd Font";
    settings = {
      # The basic colors
      foreground = "#ffffff";
      background = "#3b224c";
      selection_foreground = "#3b224c";
      selection_background = "#dbbfef";

      # Cursor colors
      cursor = "#ffffff";
      cursor_text_color = "#3b224c";

      # URL underline color when hovering with mouse
      url_color = "#dbbfef";

      # Kitty window border colors
      active_border_color = "#dbbfef";
      inactive_border_color = "#5a5977";
      bell_border_color = "#efba5d";

      # OS Window titlebar colors
      wayland_titlebar_color = "system";
      macos_titlebar_color = "system";

      # Tab bar colors
      active_tab_foreground = "#3b224c";
      active_tab_background = "#dbbfef";
      inactive_tab_foreground = "#a4a0e8";
      inactive_tab_background = "#281733";
      tab_bar_background = "#3b224c";

      # Colors for marks (marked text in the terminal)
      mark1_foreground = "#3b224c";
      mark1_background = "#dbbfef";
      mark2_foreground = "#3b224c";
      mark2_background = "#a4a0e8";
      mark3_foreground = "#3b224c";
      mark3_background = "#7aa2f7";

      # The 16 terminal colors

      # black
      color0 = "#281733";
      color8 = "#5a5977";

      # red
      color1 = "#f47868";
      color9 = "#f47868";

      # green
      color2 = "#9ff28f";
      color10 = "#9ff28f";

      # yellow
      color3 = "#efba5d";
      color11 = "#ffcd1c";

      # blue
      color4 = "#7aa2f7";
      color12 = "#a4a0e8";

      # magenta
      color5 = "#dbbfef";
      color13 = "#dbbfef";

      # cyan
      color6 = "#697C81";
      color14 = "#cccccc";

      # white
      color7 = "#a4a0e8";
      color15 = "#ffffff";
    };
  };
}
