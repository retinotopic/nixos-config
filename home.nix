{ lib,config, pkgs, pkgs-unstable, inputs, ... }:
{
  imports = [
    ./configs/waybar.nix
    ./configs/hyprland.nix
    ./configs/foot.nix
    # ./configs/helix.nix
  ];
  
  home = {
    file = {
      ".config/helix" = {
        source = ./helix;
        recursive = true;        
      };
      ".config/niri" = {
        source = ./niri;
        recursive = true;        
      };
      "nixos-everforest-light.png" = {
        source = ./nixos-everforest-light-outline.png;
      };
      "nixos-everforest-dark.png" = {
        source = ./nixos-everforest-dark-outline.png;
      };
      "swwwitcher.sh" = {
        source = ./swwwitcher.sh;
      };
      "startup.sh" = {
        source = ./startup.sh;
      };
      # ".config/helix".source = config.lib.file.mkOutOfStoreSymlink "/home/retinotopic/nixos-config/helix";
    };
      
    username = "retinotopic";
    homeDirectory = "/home/retinotopic";
    stateVersion = "24.11";
    
    sessionVariables = {
      QT_QPA_PLATFORM = "xcb";
    };
    pointerCursor = {
      enable = true;
      package = pkgs.lyra-cursors;
      name = "LyraF-cursors";
      size = 20;
    };
  };
  services = {
    # mpd-mpris.enable = true;
    swww.enable = true;
    # hyprpaper.enable = false;
    # hyprpaper.settings = {
    #   ipc = "off";
    #   splash = false;
    #   splash_offset = 2.0;
    #   preload = [ "${./nixos-everforest.png}" ];
    #   wallpaper = [ "HDMI-A-1, ${./nixos-everforest.png}" ];
    # };
    # easyeffects.enable = true;
  };
  
  home.packages = [
    pkgs-unstable.telegram-desktop
    pkgs.brave
    pkgs.waypaper
    pkgs-unstable.prismlauncher
    pkgs.discord
  ];
# brave --enable-features=VaapiVideoDecoder,VaapiVideoEncoder,VaapiIgnoreDriverChecks,CanvasOopRasterization --ozone-platform-hint=x11

  
  programs = {
    lutris = {
      enable = true;
    };
    direnv = {
      enable = true;
      nix-direnv.enable = true;
      enableBashIntegration = false;
      enableNushellIntegration = false;
      enableZshIntegration = false;
    };
    tmux = {
      enable = true;
      shortcut = "a";
      shell = "${pkgs.fish}/bin/fish";
      keyMode = "vi";
    };
    fuzzel = {
      enable = true;

      settings = {
        main = {
          font          = "jetBrainsMono NF ExtraBold:size=14,Symbols Nerd Font,Noto Color Emoji";
          terminal      = "${pkgs.foot}/bin/foot";
          layer         = "overlay";
        };
        border = {
          width = 10;
          radius = 0;
        };
        colors = {
          background      = "7fbbb3b3";# blue
          # border          = "e67e80ff";# red
          # selection       = "83c0927f";# aqua
          border          = "83c092ff";# aqua
          selection       = "e67e807f";# aqua
          
          text            = "293136ff";# black
          input           = "293136ff";# black
          placeholder     = "293136ff";# black
          match           = "293136ff";# black

          selection-match = "293136ff";# black
          selection-text  = "293136ff";# black
        };
      };
    };
    git = {
      enable = true;
      userName = "retinotopic";
      userEmail = "retinotopic@proton.me";
    };
    btop.enable = true;
    foot.enable = true;
    home-manager = {
      enable = true;       
    };
    fish = {
      enable = true;

      plugins = [
        { name = "bobthefish"; src = pkgs.fishPlugins.bobthefish; }
      ];

      interactiveShellInit = ''
        set -g theme_nerd_fonts no
        set -g fish_prompt_prefix " "
    
        set -g theme_display_user yes
        set -g theme_display_hostname yes
        set -g theme_display_git_master_branch yes
        set -g theme_show_exit_status yes

        function bobthefish_colors -S -d 'custom bobthefish color scheme (Everforest)'
          set -l dark	333c43
          set -l red	e67e80
          set -l green	a7c080
          set -l yellow dbbc7f
          set -l blue 7fbbb3
          set -l purple d699b6
          set -l aqua 83c092
          set -l orange e69875

          set -x color_initial_segment_exit     normal $blue --bold
          set -x color_initial_segment_private  normal $red
          set -x color_initial_segment_su       normal $purple --bold
          set -x color_initial_segment_jobs     normal $yellow --bold

          set -x color_path                     normal $blue
          set -x color_path_basename            normal $red --bold
          set -x color_path_nowrite             normal $yellow
          set -x color_path_nowrite_basename    normal $purple --bold

          set -x color_repo                     normal $blue
          set -x color_repo_work_tree           normal $red --bold
          set -x color_repo_dirty               normal $yellow
          set -x color_repo_staged              normal $purple

          set -x color_vi_mode_default          normal $blue --bold
          set -x color_vi_mode_insert           normal $red --bold
          set -x color_vi_mode_visual           normal $yellow --bold

          set -x color_vagrant                  normal $purple --bold
          set -x color_aws_vault                normal $yellow --bold
          set -x color_aws_vault_expired        normal $red --bold
          set -x color_username                 normal $blue --bold

          set -x color_hostname                 normal $blue
          set -x color_rvm                      normal $red --bold
          set -x color_virtualfish              normal $yellow --bold
          set -x color_virtualgo                normal $blue --bold
          set -x color_desk                     normal $aqua --bold
          set -x color_nix                      normal $purple --bold

        end
    
        set -g theme_powerline_fonts no
        set -g fish_prompt_pwd_dir_length 3
      '';
    };
    fastfetch = {
      enable = true;
      settings = {
        logo = {
          type = "file";
          source = ./nixos.txt;
          color = {
              "1" = "white";
              "2" = "blue";
              "3" = "red";
              "4" = "yellow";
          };
        };
        modules = [
          "title"
          "separator"
          "os"
          "kernel"
          "shell"
          "wm"
          "cursor"
          "terminal"
          "colors"
        ];
      };  
    };
    yazi = {
      enable = true;
      theme = {
        manager = {
          cwd = { fg = "#a7c080"; }; # Soft Green
          # Hovered
          hovered = { fg = "#2c313a"; bg = "#d3c6aa"; }; # Dark background, Soft beige foreground
          preview_hovered = { underline = true; };
          # Find
          find_keyword = { fg = "#d3c6aa"; italic = true; };                # Soft beige
          find_position = { fg = "#e8a2af"; bg = "reset"; italic = true; }; # Soft red
          # Marker
          marker_selected = { fg = "#a7c080"; bg = "#a7c080"; }; # Soft Green
          marker_copied = { fg = "#d3c6aa"; bg = "#d3c6aa"; };   # Soft beige
          marker_cut = { fg = "#e8a2af"; bg = "#e8a2af"; };      # Soft red
          # Tab
          tab_active = { fg = "#2c313a"; bg = "#d3c6aa"; };   # Dark background; Soft beige foreground
          tab_inactive = { fg = "#a7c080"; bg = "#434c5e"; }; # Soft Green on muted dark
          tab_width = 1;
          # Border
          border_symbol = "│";
          border_style = { fg = "#687d68"; }; # Muted Green
          # Highlighting
          syntect_theme = "~/.config/bat/themes/Everforest-Soft.tmTheme";
        };

        status = {
          separator_open = "";
          separator_close = "";
          separator_style = { fg = "#434c5e"; bg = "#434c5e"; }; # Muted dark
          # Mode
          mode_normal = { fg = "#2c313a"; bg = "#d3c6aa"; bold = true; }; # Dark background, Soft beige foreground
          mode_select = { fg = "#2c313a"; bg = "#a7c080"; bold = true; }; # Dark background, Soft Green foreground
          mode_unset = { fg = "#2c313a"; bg = "#e8a2af"; bold = true; };  # Dark background, Soft red foreground
          # Progress
          progress_label = { fg = "#ffffff"; bold = true; };
          progress_normal = { fg = "#d3c6aa"; bg = "#434c5e"; }; # Soft beige on muted dark
          progress_error = { fg = "#e8a2af"; bg = "#434c5e"; };  # Soft red on muted dark
          # Permissions
          permissions_t = { fg = "#d3c6aa"; }; # Soft beige
          permissions_r = { fg = "#d3c6aa"; }; # Soft beige
          permissions_w = { fg = "#e8a2af"; }; # Soft red
          permissions_x = { fg = "#a7c080"; }; # Soft Green
          permissions_s = { fg = "#687d68"; }; # Muted Green
        };

        input = {
          border = { fg = "#d3c6aa"; };    # Soft beige
          title = {};
          value = {};
          selected = { reversed = true; };
        };

        select = {
          border = { fg = "#d3c6aa"; }; # Soft beige;
          active = { fg = "#e8a2af"; }; # Soft red;
          inactive = {};
        };

        tasks = {
          border = { fg = "#d3c6aa"; };    # Soft beige
          title = {};
          hovered = { underline = true; };
        };
        which = {
          mask = { bg = "#2c313a"; };            # Dark background
          cand = { fg = "#a7c080"; };            # Soft Green
          rest = { fg = "#d3c6aa"; };            # Soft beige
          desc = { fg = "#e8a2af"; };            # Soft red
          separator = "  ";
          separator_style = { fg = "#434c5e"; }; # Muted dark
        };
        help = {
          on = { fg = "#e8a2af"; };                     # Soft red
          run = { fg = "#a7c080"; };                   # Soft Green
          desc = { fg = "#d3c6aa"; };                   # Soft beige
          hovered = { bg = "#434c5e"; bold = true; };   # Muted dark background
          footer = { fg = "#2c313a"; bg = "#d3c6aa"; }; # Dark background, Soft beige foreground
        };
        filetype = {
          rules = [
            # Images
            { mime = "image/*"; fg = "#a7c080"; } # Soft Green
            # Videos
            { mime = "video/*"; fg = "#d3c6aa"; } # Soft beige
            { mime = "audio/*"; fg = "#d3c6aa"; } # Soft beige
            # Archives
            { mime = "application/zip"; fg = "#e8a2af"; }             # Soft red
            { mime = "application/gzip"; fg = "#e8a2af"; }            # Soft red
            { mime = "application/x-tar"; fg = "#e8a2af"; }           # Soft red
            { mime = "application/x-bzip"; fg = "#e8a2af"; }          # Soft red
            { mime = "application/x-bzip2"; fg = "#e8a2af"; }         # Soft red
            { mime = "application/x-7z-compressed"; fg = "#e8a2af"; } # Soft red
            { mime = "application/x-rar"; fg = "#e8a2af"; }           # Soft red
            # Fallback
            { name = "*"; fg = "#d3c6aa"; }  # Soft beige
            { name = "*/"; fg = "#d3c6aa"; } # Soft beige
          ];
        };
      };
    };
    zellij = {
      enable = true;
      themes = {
        "everforest" = ./everforest-zellij.kdl;
      };
    };
  };
  
}
# 7794a2
# 677176
# 819199
# 85939a
# 929da3
