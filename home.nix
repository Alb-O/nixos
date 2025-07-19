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
    ./modules/hyprland.nix
    inputs.zen-browser.homeModules.twilight
  ];
  
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
    gh
    fuzzel
    _1password-cli
  ];

  programs.kitty.enable = true;
  programs.kitty.font.name = "JetBrainsMono Nerd Font";

  programs.zen-browser.enable = true;
  programs.zen-browser.policies = {
    ExtensionSettings = {
      "d634138d-c276-4fc8-924b-40a0ea21d284" = {
        install_url = "https://addons.mozilla.org/firefox/downloads/file/4314129/1password_x_password_manager-8.11.0.xpi";
        installation_mode = "force_installed";
      };
    };
  };

  # Let Home Manager manage itself
  programs.home-manager.enable = true;
}
