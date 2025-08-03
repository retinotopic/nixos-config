{ pkgs, ... }: {
    programs.fish = {
      enable = true;

      interactiveShellInit = ''
        function fish_right_prompt; end
        function fish_prompt
            export EDITOR=hx
            # alias zellij = "zellij options --theme everforest"
            
            function y
            	set tmp (mktemp -t "yazi-cwd.XXXXXX")
            	yazi $argv --cwd-file="$tmp"
            	if read -z cwd < "$tmp"; and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
            		builtin cd -- "$cwd"
            	end
            	rm -f -- "$tmp"
            end
            set -l palette 83c092 a7c080 dbbc7f e69875 e67e80 d699b6 7fbbb3
            set -l len (count $palette)
            set -l i (random 1 $len)
            set -l j (math "(($i    ) % $len) + 1")
            set -l k (math "(($i + 1) % $len) + 1")
            set -l user $palette[$i]
            set -l host $palette[$j]
            set -l time $palette[$k]

            set -l white d3c6aa
            set -l norm normal

            set -l fgblack  black
            set -l sep  \uE0B0

            set_color --background=$user $fgblack
            printf ' %s ' (whoami)
            
            set_color --background=$host $user
            printf $sep

            set_color --background=$host $fgblack
            printf '   %s ' (hostname)

            set_color --background=$time $host
            printf $sep

            set_color --background=$time $fgblack
            printf ' %s ' (date "+%H:%M")

            set_color --background=$norm $time
            printf $sep

            set_color normal
            printf '\n'

            printf '%s %s :$ ' (prompt_pwd) (__fish_git_prompt)
        end
      '';
    };
}
