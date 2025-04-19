{ lib, pkgs-unstable, ... }: {
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    systemd.enable = true;
    extraConfig = lib.concatStrings [
      ''
monitor=,preferred,auto,auto

$terminal = foot
$fileManager = thunar
$menu = fuzzel

# exec-once = $terminal
# exec-once = nm-applet &
exec-once = waybar & hyprpaper & firefox
# exec-once = killall -q waybar;sleep .5 && waybar
env = XCURSOR_SIZE,24
env = HYPRCURSOR_SIZE,24
env = LIBVA_DRIVER_NAME,nvidia
env = __GLX_VENDOR_LIBRARY_NAME,nvidia

general {
    gaps_in = 4
    gaps_out = 4

    border_size = 2

    col.active_border = rgba(83c092ee) rgba(7fbbb3ee) rgba(e67e80ee) rgba(a7c080ee) rgba(d699b6ee)
    col.inactive_border = rgba(83c09280) rgba(7fbbb380) rgba(e67e8080) rgba(a7c08080) rgba(d699b680)

    resize_on_border = true

    allow_tearing = false

    layout = dwindle
}

decoration {
    rounding = 7
    # rounding_power = 2
    active_opacity = 1.0
    inactive_opacity = 1.0

    shadow {
        enabled = false
        range = 4
        render_power = 3
        color = rgba(1a1a1aee)
    }
    blur {
        enabled = false
        size = 3
        passes = 1

        vibrancy = 0.1696
    }
}

animations {
    enabled = false
}

dwindle {
    pseudotile = true # Master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
    preserve_split = true # You probably want this
}

master {
    new_status = master
}

misc {
    force_default_wallpaper = -1 # Set to 0 or 1 to disable the anime mascot wallpapers
    disable_hyprland_logo = false # If true disables the random hyprland logo / anime girl background. :(
}

input {
    kb_layout = us,ru
    kb_variant =
    kb_model =
    kb_options = grp:alt_shift_toggle
    kb_rules =

    follow_mouse = 1

    sensitivity = 0 # -1.0 - 1.0, 0 means no modification.

    touchpad {
        natural_scroll = false
    }
}

gestures {
    workspace_swipe = false
}

device {
    name = epic-mouse-v1
    sensitivity = -0.5
}

$mainMod = SUPER # Sets "Windows" key as main modifier

bind = $mainMod, Q, exec, $terminal
bind = $mainMod, C, killactive,
bind = $mainMod, M, exit,
bind = $mainMod, E, exec, $fileManager
bind = $mainMod, V, togglefloating,
bind = $mainMod, R, exec, $menu
bind = $mainMod, P, pseudo, # dwindle
bind = $mainMod, J, togglesplit, # dwindle

bind = $mainMod SHIFT, H, movefocus, l
bind = $mainMod SHIFT, L, movefocus, r
bind = $mainMod SHIFT, K, movefocus, u
bind = $mainMod SHIFT, J, movefocus, d

bind = $mainMod, 1, workspace, 1
bind = $mainMod, 2, workspace, 2
bind = $mainMod, 3, workspace, 3
bind = $mainMod, 4, workspace, 4
bind = $mainMod, 5, workspace, 5
bind = $mainMod, 6, workspace, 6
bind = $mainMod, 7, workspace, 7
bind = $mainMod, 8, workspace, 8
bind = $mainMod, 9, workspace, 9
bind = $mainMod, 0, workspace, 10

bind = $mainMod SHIFT, 1, movetoworkspace, 1
bind = $mainMod SHIFT, 2, movetoworkspace, 2
bind = $mainMod SHIFT, 3, movetoworkspace, 3
bind = $mainMod SHIFT, 4, movetoworkspace, 4
bind = $mainMod SHIFT, 5, movetoworkspace, 5
bind = $mainMod SHIFT, 6, movetoworkspace, 6
bind = $mainMod SHIFT, 7, movetoworkspace, 7
bind = $mainMod SHIFT, 8, movetoworkspace, 8
bind = $mainMod SHIFT, 9, movetoworkspace, 9
bind = $mainMod SHIFT, 0, movetoworkspace, 10

bind = $mainMod SHIFT, S, togglespecialworkspace, magic

bind = $mainMod, mouse_down, workspace, e+1
bind = $mainMod, mouse_up, workspace, e-1

bindm = $mainMod, mouse:272, movewindow
bindm = $mainMod, mouse:273, resizewindow

bindel = ,XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+
bindel = ,XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
bindel = ,XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
bindel = ,XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle
bindel = ,XF86MonBrightnessUp, exec, brightnessctl s 10%+
bindel = ,XF86MonBrightnessDown, exec, brightnessctl s 10%-

bindl = , XF86AudioNext, exec, playerctl next
bindl = , XF86AudioPause, exec, playerctl play-pause
bindl = , XF86AudioPlay, exec, playerctl play-pause
bindl = , XF86AudioPrev, exec, playerctl previous

# Ignore maximize requests from apps. You'll probably like this.
windowrulev2 = suppressevent maximize, class:.*

# Fix some dragging issues with XWayland
windowrulev2 = nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0  
      ''
    ];
  };
}
