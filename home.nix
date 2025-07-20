{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:

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
    ./modules/hyprland/main.nix
    ./modules/kitty.nix
    ./modules/fish.nix
    ./modules/fuzzel.nix
  ];

  xdg.configFile."uwsm/env".source =
    "${config.home.sessionVariablesPackage}/etc/profile.d/hm-session-vars.sh";

  programs.git = {
    enable = true;
    extraConfig = {
      gpg = {
        format = "ssh";
      };
      "gpg \"ssh\"" = {
        program = "${pkgs._1password-gui}/bin/op-ssh-sign";
      };
      commit = {
        gpgsign = true;
      };

      user = {
        signingKey = builtins.getEnv "GIT_SIGNING_KEY_PATH";
      };
      "gpg.ssh" = {
        allowedSignersFile = "${pkgs.writeText "allowed_signers" (builtins.getEnv "ALLOWED_SIGNERS")}";
      };
    };
  };

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
    age
    sops
    nil
    nixd
    opencode
    swww
    grc
    _1password-cli
    _1password-gui
  ];



  home.sessionVariables = {
    EDITOR = "hx";
    TERMINAL = "kitty -e fish";
    NIXOS_OZONE_WL = "1";
  };

  programs.firefox = {
    enable = true;
    profiles.albert = {
      search.engines = {
        "Nix Packages" = {
          urls = [
            {
              template = "https://search.nixos.org/packages";
              params = [
                {
                  name = "type";
                  value = "packages";
                }
                {
                  name = "query";
                  value = "{searchTerms}";
                }
              ];
            }
          ];
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


  # Let Home Manager manage itself
  # programs.home-manager.enable = true;

  systemd.user.services.swww-daemon = {
    Unit = {
      Description = "swww wallpaper daemon";
      After = [ "graphical-session.target" ];
    };
    Service = {
      ExecStart = "${pkgs.swww}/bin/swww-daemon";
      ExecStartPost = "${pkgs.swww}/bin/swww clear '#3b224c'";
      Restart = "on-failure";
    };
    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };

  systemd.user.services."1password-gui" = {
    Unit = {
      Description = "1Password GUI";
      After = [ "graphical-session.target" ];
    };
    Service = {
      ExecStart = "${pkgs._1password-gui}/bin/1password --silent";
      Restart = "on-failure";
    };
    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };
}
