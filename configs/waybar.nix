{ pkgs, ... }: {
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";

        modules-left = [
          "custom/arrowleft0"
          
          "niri/workspaces"
          "custom/arrowleft1"
          
          "user"
          "custom/arrowleft2"
          
          "network"
          "custom/arrowleft3"
          
          "wireplumber"
          "custom/arrowleft4"
        ];
        
        modules-center = [
          "custom/arrowcenter1"
          "niri/window"
          "custom/arrowcenter2"
        ];

        modules-right = [          
          "custom/arrowright2"
          "disk"
          
          "custom/arrowright3"
          "memory"
          
          "custom/arrowright4"
          "cpu"
          
          "custom/arrowright5"
          "niri/language"
          
          "custom/arrowright6"
          "clock#date"
          
          "custom/arrowright7"
          "clock#time"
          "tray"
        ];

        user = {
          format = " {user}";
          icon = false;
        };

        disk = {
          interval = 30;
          format = "{free}";
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
          format = "{:%H:%M }";
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
          format-alt = "{avg_frequency}GHz";
          states = {
            warning = 70;
            critical = 90;
          };
        };
        "niri/window" = {
        	format = "{app_id}";
          icon = true;
          expand = false;
          icon-size = 20;
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
        
        "niri/language" = {
        	format = " {}";
        	format-en = "EN";
        	format-ru = "RU";
        };
        memory = {
          interval = 5;
          format = " {used:0.1f}";
          states = {
            warning = 70;
            critical = 90;
          };
          tooltip = false;
        };

        network = {
          interval = 5;
          format = "  {bandwidthDownBytes} {bandwidthUpBytes}";
          format-wifi = "   {bandwidthDownBytes} {bandwidthUpBytes} ";
          format-ethernet = "  {bandwidthDownBytes} {bandwidthUpBytes} ";
          format-disconnected = " 󰈂 {bandwidthDownBytes} {bandwidthUpBytes} ";
          format-linked = " 󰈀 {bandwidthDownBytes} {bandwidthUpBytes} ";
          tooltip = false;
          on-click = "foot nmtui";
        };
 
        "niri/workspaces" = {
        	format = "{icon}";
        	format-icons = {
        		focused = "███";
        		hover = "███";
        		urgent = "███";
          };
        };

        "hyprland/workspaces" = {
             format = "{icon}";
             on-scroll-up = "hyprctl dispatch workspace e+1";
             on-scroll-down = "hyprctl dispatch workspace e-1";
        };
        
        "wireplumber" = {
            format = "{volume}% {icon} ";
            format-muted = "  0%";
            on-click = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
            on-click-right = "pwvucontrol";
            format-icons = [ "" "" "" ];
        };
        cava = {
            # cava_config=" ${../configs/cava/cava.conf}" ;
            framerate = 30;
            autosens = 1;
            sensitivity = 2;
            bars = 40;
            lower_cutoff_freq = 50;
            higher_cutoff_freq = 10000;
            method = "pipewire";
            source = "auto";
            stereo = true;
            reverse = false;
            bar_delimiter = 0;
            monstercat = false;
            waves = false;
            noise_reduction = 0.77;
            input_delay = 0;
            format-icons = ["▁" "▂" "▃" "▄" "▅" "▆" "▇" "█" ];
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
          icon-size = 20;
        };

        "custom/arrowleft0" = {
          format = "";
          tooltip = false;
        };
        "custom/arrowleft1" = {
          format = "";
          tooltip = false;
        };

        "custom/arrowleft2" = {
          format = "";
          tooltip = false;
        };
        "custom/arrowleft3" = {
          format = "";
          tooltip = false;
        };
        "custom/arrowleft4" = {
          format = "";
          tooltip = false;
        };
        "custom/arrowleft5" = {
          format = "";
          tooltip = false;
        };

        "custom/arrowright1" = {
          format = "";
          tooltip = false;
        };
        
        "custom/arrowright2" = {
          format = "";
          tooltip = false;
        };

        "custom/arrowright3" = {
          format = "";
          tooltip = false;
        };

        "custom/arrowright4" = {
          format = "";
          tooltip = false;
        };

        "custom/arrowright5" = {
          format = "";
          tooltip = false;
        };

        "custom/arrowright6" = {
          format = "";
          tooltip = false;
        };

        "custom/arrowright7" = {
          format = "";
          tooltip = false;
        };

        "custom/arrowcenter1" = {
          format = "";
          tooltip = false;
        };
        "custom/arrowcenter2" = {
          format = "";
          tooltip = false;
        };

      };
    };
    style = ./waybar.css;
  };
}
