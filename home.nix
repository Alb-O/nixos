{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:

let
  secrets = import ./secrets.nix;
in
{
  home.username = "albert";
  home.homeDirectory = "/home/albert";
  home.stateVersion = "23.11";

  imports = [
    ./modules/hyprland/main.nix
    ./modules/kitty.nix
    ./modules/fish.nix
    ./modules/fuzzel.nix
    ./modules/firefox.nix
    (import ./modules/git.nix { inherit config pkgs lib secrets;  })
  ];

  xdg.configFile."uwsm/env".source =
    "${config.home.sessionVariablesPackage}/etc/profile.d/hm-session-vars.sh";

  home.file.".ssh/id_ed25519.pub".text = secrets.pubkey;

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
    markdown-oxide
  ];

  home.sessionVariables = {
    EDITOR = "hx";
    TERMINAL = "${lib.getExe pkgs.kitty} -e ${lib.getExe pkgs.fish}";
    NIXOS_OZONE_WL = "1";
  };


  # Let Home Manager manage itself
  # programs.home-manager.enable = true;

  systemd.user.services.swww-daemon = {
    Unit = {
      Description = "swww wallpaper daemon";
      After = [ "graphical-session.target" ];
    };
    Service = {
      ExecStart = "${lib.getExe pkgs.swww}-daemon";
      ExecStartPost = "${lib.getExe pkgs.swww} clear '#3b224c'";
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
      ExecStart = "${lib.getExe pkgs._1password-gui} --silent --enable-features=UseOzonePlatform --ozone-platform=wayland";
      Restart = "on-failure";
    };
    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };
}
