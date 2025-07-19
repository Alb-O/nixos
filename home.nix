{ config, pkgs, lib, inputs, ... }:

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
  ];
  
  # The home.packages option allows you to install packages into your
  # user profile.
  home.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    helix
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

  programs.firefox = {
    enable = true;
    profiles.albert = {
      search.engines = {
        "Nix Packages" = {
          urls = [{
            template = "https://search.nixos.org/packages";
            params = [
              { name = "type"; value = "packages"; }
              { name = "query"; value = "{searchTerms}"; }
            ];
          }];
          icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
          definedAliases = [ "@np" ];
        };
      };
      search.force = true;

      bookmarks = {
        force = true;
        settings = [
          {
            name = "wikipedia";
            tags = [ "wiki" ];
            keyword = "wiki";
            url = "https://en.wikipedia.org/wiki/Special:Search?search=%s&go=Go";
          }
        ];
      };

      settings = {
        "dom.security.https_only_mode" = true;
        "browser.download.panel.shown" = true;
        "identity.fxaccounts.enabled" = false;
        "signon.rememberSignons" = false;
      };
      extensions.packages = [
        pkgs.nur.repos.rycee.firefox-addons."onepassword-password-manager"
        pkgs.nur.repos.rycee.firefox-addons.ublock-origin
      ];
    };
  };

  programs.ssh = {
    enable = true;
    extraConfig = ''
      Host *
          IdentityAgent ~/.1password/ag
    '';
  };

  programs.git = {
    enable = true;
    extraConfig = {
      gpg = {
        format = "ssh";
      };
      "gpg \"ssh\"" = {
        program = "${lib.getExe' pkgs._1password-gui "op-ssh-sign"}";
      };
      commit = {
        gpgsign = true;
      };

      user = {
        signingKey = "...";
      };
    };
  };

  # Let Home Manager manage itself
  programs.home-manager.enable = true;
}
