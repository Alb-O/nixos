{ config, pkgs, inputs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "albert";
  home.homeDirectory = "/home/albert";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You can update this value when you update Home Manager.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  imports = [
    inputs.zen-browser.homeModules.twilight
  ];

  programs.zen-browser.enable = true;

  programs.kitty.enable = true;
  programs.kitty.font.name = "JetBrainsMono Nerd Font";
  wayland.windowManager.hyprland.enable = true;

  wayland.windowManager.hyprland.settings = {
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
  };
  
  # The home.packages option allows you to install packages into your
  # user profile.
  home.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    helix
    git
    fastfetch
    ripgrep
    fzf
    gemini-cli
    fuzzel
  ];

  # Let Home Manager manage itself
  programs.home-manager.enable = true;
}
