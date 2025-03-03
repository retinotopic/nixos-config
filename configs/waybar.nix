{ pkgs, ... }: {
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";

        modules-left = [
          "hyprland/workspaces"
          "custom/arrow11"
        ];
        
        modules-center = [ "hyprland/window" ];
        
        modules-right = [
          "custom/arrow10"
          "custom/arrow9"
          "custom/pipewire"
          "custom/arrow8"
          "network"
          "custom/arrow7"
          "memory"
          "custom/arrow6"
          "cpu"
          "custom/arrow5"
          "temperature"
          "custom/arrow4"
          "battery"
          "custom/arrow3"
          "hyprland/language"
          "custom/arrow2"
          "tray"
          "clock#date"
          "custom/arrow1"
          "clock#time"
        ];

        battery = {
          interval = 10;
          states = {
            warning = 30;
            critical = 15;
          };
          format-time = "{H}:{M:02}";
          format = "{icon} {capacity}% ({time})";
          format-charging = " {capacity}% ({time})";
          format-charging-full = " {capacity}%";
          format-full = "{icon} {capacity}%";
          format-alt = "{icon} {power}W";
          format-icons = [
            ""
            ""
            ""
            ""
            ""
          ];
          tooltip = false;
        };

        "clock#time" = {
          interval = 10;
          format = "{:%H:%M}";
          tooltip = false;
        };

        "clock#date" = {
          interval = 20;
          format = "{:%e %b %Y}";
          tooltip = false;
        };

        cpu = {
          interval = 5;
          tooltip = false;
          format = " {usage}%";
          format-alt = " {load}";
          states = {
            warning = 70;
            critical = 90;
          };
        };
        
        "hyprland/language" = {
            format = " {}";
            format-en = "EN (US)";
            format-ru = "RU";
        };
        
        memory = {
          interval = 5;
          format = " {used:0.1f}G/{total:0.1f}G";
          states = {
            warning = 70;
            critical = 90;
          };
          tooltip = false;
        };

        network = {
          interval = 5;
          format-wifi = " {essid} ({signalStrength}%)";
          format-ethernet = " {ifname}";
          format-disconnected = "No connection";
          format-alt = " {ipaddr}/{cidr}";
          tooltip = false;
        };
 
        "hyprland/workspaces" = {
             format = "{icon}";
             on-scroll-up = "hyprctl dispatch workspace e+1";
             on-scroll-down = "hyprctl dispatch workspace e-1";
        };

        "custom/pipewire" = {
          exec = "pw-volume status";
          return-type = "json";
          interval = "once";
          signal = 8;
          format = "{icon} {percentage}";
          format-icons = {
            mute = "";
            default = [ "" "" ];
          };
        };
        
        temperature = {
          critical-threshold = 90;
          interval = 5;
          format = "{icon} {temperatureC}°";
          format-icons = [
            ""
            ""
            ""
            ""
            ""
          ];
          tooltip = false;
        };

        tray = {
          icon-size = 18;
        };

        "custom/arrow1" = {
          format = "";
          tooltip = false;
        };

        "custom/arrow2" = {
          format = "";
          tooltip = false;
        };

        "custom/arrow3" = {
          format = "";
          tooltip = false;
        };

        "custom/arrow4" = {
          format = "";
          tooltip = false;
        };

        "custom/arrow5" = {
          format = "";
          tooltip = false;
        };

        "custom/arrow6" = {
          format = "";
          tooltip = false;
        };

        "custom/arrow7" = {
          format = "";
          tooltip = false;
        };

        "custom/arrow8" = {
          format = "";
          tooltip = false;
        };

        "custom/arrow9" = {
          format = "";
          tooltip = false;
        };

        "custom/arrow10" = {
          format = "";
          tooltip = false;
        };

        "custom/arrow11" = {
          format = "";
          tooltip = false;
        };
      };
    };

    style = ./waybar.css;
  };
}
