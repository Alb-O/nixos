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
     ./modules/hyprland.nix
     ./modules/kitty.nix
     ./modules/fish.nix
     inputs.sops-nix.homeManagerModules.sops
   ];

  sops.defaultSopsFile = ./secrets/secrets.yaml;
  sops.defaultSopsFormat = "yaml";
  sops.age.keyFile = "/home/albert/.config/sops/age/keys.txt";

  sops.secrets.git-signing-key = {
    path = "/home/albert/.ssh/signing.key";
    mode = "0600";
  };
  sops.secrets.allowed_signers = {
    path = "/home/albert/.ssh/allowed_signers";
    mode = "0644";
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
    _1password-cli
    _1password-gui
    age
    sops
    nil
    nixd
    opencode
  ];

  home.sessionVariables = {
    EDITOR = "hx";
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
        program = "${pkgs._1password-gui}/bin/op-ssh-sign";
      };
      commit = {
        gpgsign = true;
      };

      user = {
        signingKey = "/home/albert/.ssh/signing.key";
      };
      "gpg.ssh" = {
        allowedSignersFile = "/home/albert/.ssh/allowed_signers";
      };
    };
  };

  # Let Home Manager manage itself
  programs.home-manager.enable = true;
}
