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
          "hyprland/window"
        ];
     
        modules-right = [          
          "custom/arrow2"
          "wireplumber"
          
          "custom/arrow3"
          "memory"
          
          "custom/arrow4"
          "cpu"
          
          "custom/arrow5"
          "hyprland/language"
          
          "custom/arrow6"
          "clock#date"
          
          "custom/arrow7"
          "clock#time"
          "tray"
        ];

        user = {
          format = "{user}";
          avatar = "${../nixoslogo.png}";
          height = 20;
          width = 20;
          icon = false;
        };

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
          format = " {usage}%";
          format-alt = "{load}";
          states = {
            warning = 70;
            critical = 90;
          };
        };

        "hyprland/window" = {
          format = "{title}";
          max-length = 100;
          icon = true;
          icon-size = 20;
        };

        "hyprland/language" = {
            format = " {}";
            format-en = "EN";
            format-ru = "RU";
        };
        
        memory = {
          interval = 5;
          format = " {used:0.1f}G/{total:0.1f}G";
          states = {
            warning = 70;
            critical = 90;
          };
          tooltip = false;
        };

        network = {
          interval = 5;
          format-wifi = " {essid} ({signalStrength}%)";
          format-ethernet = " {ifname}";
          format-disconnected = "No connection";
          format-alt = " {ipaddr}/{cidr}";
          tooltip = false;
        };
 
        "hyprland/workspaces" = {
             format = "{icon}";
             on-scroll-up = "hyprctl dispatch workspace e+1";
             on-scroll-down = "hyprctl dispatch workspace e-1";
        };
        
        "wireplumber" = {
            format = "{volume}% {icon}";
            format-muted = "";
            on-click = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
            on-click-right = "pwvucontrol";
            format-icons = [ "" "" "" ];
        };
              
        # temperature = {
        #   critical-threshold = 90;
        #   interval = 5;
        #   format = "{icon} {temperatureC}°";
        #   format-icons = [
        #     ""
        #     ""
        #     ""
        #     ""
        #     ""
        #   ];
        #   tooltip = false;
        # };

        tray = {
          icon-size = 20;
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
