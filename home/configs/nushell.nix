{ pkgs-unstable, inputs, ... }: {
    pkgs-wrapped.nushell = (inputs.wrappers.wrapperModules.nushell.apply {
        pkgs = pkgs-unstable;
        "env.nu".content = ''
        # Editor
        $env.EDITOR = "hx"
        $env.VISUAL = "hx"
        '';

        "config.nu".content = ''
        # Editor
        $env.config.buffer_editor = "hx"

        # Disable right prompt
        $env.PROMPT_COMMAND_RIGHT = ""

        # Disable default prompt indicators
        $env.PROMPT_INDICATOR = ""
        $env.PROMPT_INDICATOR_VI_INSERT = ""
        $env.PROMPT_INDICATOR_VI_NORMAL = ""

        # Yazi wrapper
        def --env y [...args] {
            let tmp = (mktemp -t "yazi-cwd.XXXXXX")

            ^yazi ...$args --cwd-file $tmp

            let cwd = (open $tmp)

            if $cwd != $env.PWD and ($cwd | path exists) {
                cd $cwd
            }

            rm -fp $tmp
        }

        # Custom prompt
        $env.PROMPT_COMMAND = {||
            # Everforest palette
            let palette = [
                "#83c092"
                "#a7c080"
                "#dbbc7f"
                "#e69875"
                "#e67e80"
                "#d699b6"
                "#7fbbb3"
            ]

            # Random colors
            let i = (random int 0..6)
            let j = (($i + 1) mod 7)
            let k = (($i + 2) mod 7)

            let user_color = ($palette | get $i)
            let host_color = ($palette | get $j)
            let time_color = ($palette | get $k)

            # Background styles
            let user_style = (ansi --escape {
                fg: "black"
                bg: $user_color
            })

            let host_style = (ansi --escape {
                fg: "black"
                bg: $host_color
            })

            let time_style = (ansi --escape {
                fg: "black"
                bg: $time_color
            })

            # Powerline separators
            let user_host_sep = (ansi --escape {
                fg: $user_color
                bg: $host_color
            })

            let host_time_sep = (ansi --escape {
                fg: $host_color
                bg: $time_color
            })

            let time_end_sep = (ansi --escape {
                fg: $time_color
                bg: "default"
            })

            # System information
            let user = (^whoami | str trim)
            let host = (^hostname | str trim)
            let clock = (date now | format date "%H:%M")

            # Current directory
            let cwd = (try {
                let relative = ($env.PWD | path relative-to $env.HOME)

                if $relative == "." or $relative == "" {
                    "~"
                } else {
                    $"~/($relative)"
                }
            } catch {
                $env.PWD
            })

            # Git information
            let git_branch = (^git branch --show-current | complete)
            let git_status = (^git status --porcelain | complete)

            let branch = ($git_branch.stdout | str trim)

            let dirty = if (
                $git_status.exit_code == 0
                and ($git_status.stdout | str trim) != ""
            ) {
                "*"
            } else {
                ""
            }

            let git_prompt = if $branch != "" {
                $"(ansi yellow)($branch)($dirty)(ansi reset)"
            } else {
                ""
            }

            # First line
            let top = $"($user_style) ($user) ($user_host_sep)($host_style)   ($host) ($host_time_sep)($time_style) ($clock) ($time_end_sep)(ansi reset)"

            # Second line
            $"($top)\n($cwd) ($git_prompt) :$ "
        }
        '';
    }).wrapper;
}
