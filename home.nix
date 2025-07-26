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
  };
  services = {
    mpd-mpris.enable = true;
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

        function bobthefish_colors -S -d 'custom bobthefish color scheme (Everforest)'
          set -l dark	333c43
          set -l red	e67e80
          set -l green	a7c080
          set -l yellow dbbc7f
          set -l blue 7fbbb3
          set -l purple d699b6
          set -l aqua 83c092
          set -l orange e69875

          set -x color_initial_segment_exit     $dark $blue --bold
          set -x color_initial_segment_private  $dark $red
          set -x color_initial_segment_su       $dark $purple --bold
          set -x color_initial_segment_jobs     $dark $yellow --bold

          set -x color_path                     $dark $blue
          set -x color_path_basename            $dark $red --bold
          set -x color_path_nowrite             $dark $yellow
          set -x color_path_nowrite_basename    $dark $purple --bold

          set -x color_repo                     $dark $blue
          set -x color_repo_work_tree           $dark $red --bold
          set -x color_repo_dirty               $dark $yellow
          set -x color_repo_staged              $dark $purple

          set -x color_vi_mode_default          $dark $blue --bold
          set -x color_vi_mode_insert           $dark $red --bold
          set -x color_vi_mode_visual           $dark $yellow --bold

          set -x color_vagrant                  $dark $purple --bold
          set -x color_aws_vault                $dark $yellow --bold
          set -x color_aws_vault_expired        $dark $red --bold
          set -x color_username                 $dark $blue --bold

          set -x color_hostname                 $dark $blue
          set -x color_rvm                      $dark $red --bold
          set -x color_virtualfish              $dark $yellow --bold
          set -x color_virtualgo                $dark $blue --bold
          set -x color_desk                     $dark $aqua --bold
          set -x color_nix                      $dark $purple --bold

        end
    
        set -g theme_powerline_fonts yes
        set -g fish_prompt_pwd_dir_length 3
      '';
      };
  };

}
#   plugins = [
#     { name = "bobthefish"; src = pkgs.fishPlugins.bobthefish; }
#   ];

#   interactiveShellInit = ''
#     set -g theme_nerd_fonts yes
#     set -g fish_prompt_prefix " "
    
#     set -g theme_display_user yes
#     set -g theme_display_hostname yes
#     set -g theme_display_git_master_branch yes
#     set -g theme_show_exit_status yes
#     set -g theme_color_scheme user

#     set -g theme_color_path              7fbbb3 #blue
#     set -g theme_color_git               83c092 #aqua
#     set -g theme_color_cwd               e67e80 #red
#     set -g theme_color_git_worktree      dbbc7f #yellow
#     set -g theme_color_error             d699b6 #purple
#     set -g theme_color_command_duration  a7c080 #green
#     set -g theme_color_virtualenv        d699b6 #purple

#     set -g theme_color_user              7fbbb3
#     set -g theme_color_host              83c092
#     set -g theme_color_separator         333c43 #dark
#     set -g theme_color_git_dirty         e69875 #orange
#     set -g theme_color_git_staged        d699b6
#     set -g theme_color_git_branch        a7c080
#     set -g theme_color_sudo              e67e80
#     set -g theme_color_jobs              dbbc7f

#     set -g theme_powerline_fonts yes
#     set -g fish_prompt_pwd_dir_length 3
#   '';
# };
