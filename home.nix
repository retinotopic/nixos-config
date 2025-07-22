{ config, pkgs, pkgs-unstable, inputs, ... }:
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
        source = ./nixos-everforest-light.png;
      };
      "nixos-everforest-dark.png" = {
        source = ./nixos-everforest-dark.png;
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
  };
  services = {
    swww.enable = true;
    hyprpaper.enable = false;
    hyprpaper.settings = {
      ipc = "off";
      splash = false;
      splash_offset = 2.0;
      preload = [ "${./nixos-everforest.png}" ];
      wallpaper = [ "HDMI-A-1, ${./nixos-everforest.png}" ];
    };
    easyeffects.enable = true;
  };
  
  home.packages = [
    pkgs-unstable.telegram-desktop
    pkgs.brave
    pkgs-unstable.zellij
    pkgs.davinci-resolve-studio
    pkgs.waypaper
    pkgs.davinci-resolve
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
          terminal = "${pkgs.foot}/bin/foot";
          layer = "overlay";
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
    yazi.enable = true;
    home-manager = {
      enable = true;       
    };
    fish = {
      enable = true;

      plugins = [
        { name = "bobthefish"; src = pkgs.fishPlugins.bobthefish; }
      ];

      interactiveShellInit = ''
        set -g theme_nerd_fonts yes
        set -g fish_prompt_prefix " "
        
        set -g theme_display_user yes
        set -g theme_display_hostname yes
        set -g theme_display_git_master_branch yes
        set -g theme_show_exit_status yes
        set -g theme_color_scheme terminal

        set -g theme_color_path              7fbbb3 #blue
        set -g theme_color_git               83c092 #aqua
        set -g theme_color_cwd               e67e80 #red
        set -g theme_color_git_worktree      dbbc7f #yellow
        set -g theme_color_error             d699b6 #purple
        set -g theme_color_command_duration  a7c080 #green
        set -g theme_color_virtualenv        d699b6 #purple

        set -g theme_powerline_fonts yes
        set -g fish_prompt_pwd_dir_length 3
      '';
    };
  };

}
