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
  wayland.windowManager.hyprland.enable = true;

  wayland.windowManager.hyprland.settings = {
    "$mod" = "SUPER";
    "bind" = [
      "$mod, Return, exec, kitty"
      "$mod, Q, killactive,"
      "$mod, M, exit,"
    ];
  };
  
  # The home.packages option allows you to install packages into your
  # user profile.
  home.packages = with pkgs; [
    helix
    git
    fastfetch
    ripgrep
    fzf
    gemini-cli
  ];

  # Let Home Manager manage itself
  programs.home-manager.enable = true;
}
