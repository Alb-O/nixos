{ config, pkgs, ... }:

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

  # The home.packages option allows you to install packages into your
  # user profile.
  home.packages = [
    pkgs.git
    pkgs.neovim
    pkgs.ripgrep
    pkgs.fzf
  ];

  # Basic git configuration
  programs.git = {
    enable = true;
    userName = "Albert";
    userEmail = "albert@example.com";
  };

  # Let Home Manager manage itself
  programs.home-manager.enable = true;
}
