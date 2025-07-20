# autostart.nix
{
  autostart = {
    "exec-once" = [
      "uwsm app -- 1password-gui --silent"
      "uwsm app -- swww-daemon"
      "swww clear '#3b224c'"
    ];
    "workspace" = [
      "w[tv1], gapsout:0, gapsin:0"
      "f[1], gapsout:0, gapsin:0"
    ];
    "windowrule" = [
      "bordersize 0, floating:0, onworkspace:w[tv1]"
      "rounding 0, floating:0, onworkspace:w[tv1]"
      "bordersize 0, floating:0, onworkspace:f[1]"
      "rounding 0, floating:0, onworkspace:f[1]"
    ];
  };
}
