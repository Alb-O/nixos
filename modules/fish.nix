{ pkgs, ... }:

{
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      function fish_greeting
          fastfetch
      end
      function fish_prompt
        set_color purple
        date "+%c"
        set_color green
        echo (prompt_pwd) (set_color normal)'-> '
      end
      function fish_right_prompt
        set_color blue
        fish_git_prompt
      end
    '';
    functions = {
      ghcs = {
        body = "gh copilot suggest $argv";
      };
      argv = {
        body = "gh copilot explain $argv";
      };
      enter-low-power = {
        body = ''
          # CPU Governor
          echo "Setting CPU governor to powersave..."
          for cpu in /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
              echo powersave | sudo tee $cpu > /dev/null
          end

          # Systemd Target
          echo "Switching to multi-user.target..."
          sudo systemctl isolate multi-user.target
        '';
      };
      exit-low-power = {
        body = ''
          # CPU Governor
          echo "Setting CPU governor to schedutil..."
          for cpu in /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
              echo schedutil | sudo tee $cpu > /dev/null
          end

          # Systemd Target
          echo "Switching to graphical.target..."
          sudo systemctl isolate graphical.target
        '';
      };
      google = {
        body = ''gemini -m "gemini-2.5-flash" -p "Search on Google: $(argv) and summarize the results."'';
      };
      rg = {
        body = "command rg --hyperlink-format=kitty $argv";
      };
      sysdown = {
        wraps = "sudo systemctl isolate multi-user.target";
        body = "sudo systemctl isolate multi-user.target $argv";
      };
      sysup = {
        wraps = "sudo systemctl isolate graphical.target";
        body = "sudo systemctl isolate graphical.target $argv";
      };
      yayf = {
        wraps = "yay -Slq --color | fzf --multi --preview 'yay -Sii {1}' --preview-window=down:75% | xargs -ro yay -S";
        body = "yay -Slq --color | fzf --multi --preview 'yay -Sii {1}' --preview-window=down:75% | xargs -ro yay -S $argv";
      };
    };
    plugins = [
      { name = "grc"; src = pkgs.fishPlugins.grc.src; }
      { name = "z"; src = pkgs.fishPlugins.z.src; }
    ];
  };
}
