{ pkgs, ... }: {
    programs.fish = {
      enable = true;

      # plugins = [
      #   { name = "bobthefish"; src = pkgs.fishPlugins.bobthefish; }
      # ];

      interactiveShellInit = ''
        set -g theme_nerd_fonts no
        set -g fish_prompt_prefix " "
    
        set -g theme_display_user yes
        set -g theme_display_hostname yes
        set -g theme_display_git_master_branch yes
        set -g theme_show_exit_status yes

        # function bobthefish_colors -S -d 'custom bobthefish color scheme (Everforest)'
        #   set -l dark	424b50
        #   set -l red e67e80
        #   set -l green a7c080
        #   set -l yellow dbbc7f
        #   set -l blue 7fbbb3
        #   set -l purple d699b6
        #   set -l aqua 83c092
        #   set -l orange e69875
        #   set -l white d3c6aa

        #   set -x color_initial_segment_exit     $red $dark --bold
        #   set -x color_initial_segment_private  $purple $dark
        #   set -x color_initial_segment_su       $orange $darl --bold
        #   set -x color_initial_segment_jobs     $yellow $dark --bold

        #   set -x color_path                     normal $blue
        #   set -x color_path_basename            normal $red --bold
        #   set -x color_path_nowrite             normal $yellow
        #   set -x color_path_nowrite_basename    normal $purple --bold

        #   set -x color_repo                     normal $blue
        #   set -x color_repo_work_tree           normal $red --bold
        #   set -x color_repo_dirty               normal $yellow
        #   set -x color_repo_staged              normal $purple

        #   set -x color_vi_mode_default          normal $blue --bold
        #   set -x color_vi_mode_insert           normal $red --bold
        #   set -x color_vi_mode_visual           normal $yellow --bold

        #   set -x color_vagrant                  normal $purple --bold
        #   set -x color_aws_vault                normal $yellow --bold
        #   set -x color_aws_vault_expired        normal $red --bold
          
        #   set -x color_username                 $aqua $dark --bold
        #   set -x color_hostname                 $blue $dark
          
        #   set -x color_rvm                      normal $red --bold
        #   set -x color_virtualfish              normal $yellow --bold
        #   set -x color_virtualgo                normal $blue --bold
        #   set -x color_desk                     normal $aqua --bold
        #   set -x color_nix                      normal $purple --bold
        # end
    
        set -g theme_powerline_fonts no
        set -g fish_prompt_pwd_dir_length 3

        function fish_prompt
            set -l user 83c092
            set -l host 7fbbb3
            set -l white d3c6aa

            set -l norm normal

            set -l fg_black  black
            set -l sep_char  \uE0B0

            set_color --background=$user $fg_black
            printf ' %s ' (whoami)
            
            set_color --background=$host $user
            printf $sep_char

            set_color --background=$host $fg_black
            printf ' %s ' (hostname)

            set_color --background=$norm $host
            printf $sep_char

            set_color normal
            printf '\n'

            printf '%s \$ ' (prompt_pwd)
        end
      '';
    };
}
