{ pkgs, ... }: {
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";

        modules-left = [
          "group/power"
          "custom/arrowleft0"
          
          "niri/workspaces"
          "custom/arrowleft1"
          
          "niri/language"
          "custom/arrowleft2"
          
          "wireplumber"
          "custom/arrowleft3"

          "user"
          "custom/arrowleft4"
          
          "network"
          "custom/arrowleft5"
          "custom/arrowleft6"
         
        ];
        
        modules-center = [
          "custom/arrowcenterL1"
          "custom/arrowcenterL2"
          "niri/window"
          "custom/cavacolors"
          "custom/arrowcenterR1"
          "custom/arrowcenterR2"
        ];
        
        modules-right = [          
          "custom/arrowright1"
          "custom/arrowright2"
          "clock#date"
          
          "custom/arrowright3"
          "clock#time"
          
          "custom/arrowright4"
          "disk"
          
          "custom/arrowright5"
          "memory"
          
          "custom/arrowright6"
          "cpu"
          "custom/arrowright7"
          "group/tweaks"
        ];

        "group/tweaks" = {
            orientation= "inherit";
            drawer= {
                "transition-duration"= 500;
                "children-class"= "not-power";
                "transition-left-to-right" = false;
            };
            "modules"= [
                "custom/darkmode"
                "tray"
            ];
        };
        "group/power" = {
            orientation= "inherit";
            drawer= {
                "transition-duration"= 500;
                "children-class"= "not-power";
                "transition-left-to-right" = true;
            };
            "modules"= [
                "custom/menupower"
                "custom/power"
                "custom/reboot"
            ];
        };
        "custom/reboot" = {
            "format"= " ";
            "tooltip"= false;
            "on-click"= "reboot";
        };
        "custom/darkmode" = {
            "format"= " ";
            "tooltip"= false;
            "on-click"= "bash swwwitcher.sh";
        };
        "custom/power"= {
            "format"= "⏻ ";
            "tooltip"= false;
            "on-click"= "shutdown now";
        };
        "custom/menupower"= {
            "format"= " ⏼ ";
            "tooltip"= false;
        };
        "custom/cavacolors"= {
          "format" = "{text}";
          "tooltip" = false;
          "exec" = "${pkgs.go}/bin/go run ${../go-cli-tools/cavacolors/main.go}";
          "return-type" = "json";
          "exec-on-event" = true;
          "on-click" = " ";
          "tail" = true;
        };

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
          format = " {usage}% ";
          format-alt = "{avg_frequency}GHz";
          states = {
            warning = 70;
            critical = 90;
          };
        };
        "niri/window" = {
        	format = "{title}";
          icon = true;
          expand = false;
          icon-size = 20;
          max-length = 15 ;
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
        		focused = "██";
        		hover = "██";
        		urgent = "██";
          };
        };
#█
#
#
        "hyprland/workspaces" = {
             format = "{icon}";
             on-scroll-up = "hyprctl dispatch workspace e+1";
             on-scroll-down = "hyprctl dispatch workspace e-1";
        };
        
        "wireplumber" = {
            format = "{volume}% {icon} ";
            format-muted = "0%  ";
            on-click = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
            on-click-right = "pwvucontrol";
            on-scroll-up = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+";
            on-scroll-down = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-";
            format-icons = [ "" "" "" ];
        };
        cava = {
          # cava_config="${../configs/cava/config}" ;
          framerate = 30;
          autosens = 1;
          sensitivity = 2;
          bars = 10;
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
          spacing = 5;
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

        "custom/arrowcenterL1" = {
          format = "";
          tooltip = false;
        };
        "custom/arrowcenterR1" = {
          format = "";
          tooltip = false;
        };

      };
    };
    style = ./waybar.css;
  };
}
