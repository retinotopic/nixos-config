{ lib,config, pkgs, pkgs-unstable, pkgs-staging, inputs, ... }:
{
  imports = [
    ./configs/hyprland.nix
    ./configs/foot.nix
    ./configs/yazi.nix
    ./configs/fuzzel.nix
    ./configs/fish.nix
    ./configs/fastfetch.nix
    ./configs/btop.nix
  ];
  
  home = {
    file = {
      ".config/helix" = {
        source = ./helix;
        recursive = true;        
      };
      "CuteShell" = {
        source = inputs.cuteshell;
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
      "nixos-onedark-onedark.png" = {
        source = ./nixos-onedark-onedark.png;
      };
      # ".config/helix".source = config.lib.file.mkOutOfStoreSymlink "/home/retinotopic/nixos-config/helix";
    };
      
    username = "retinotopic";
    homeDirectory = "/home/retinotopic";
    stateVersion = "24.11";
    
    sessionVariables = {
      QT_QPA_PLATFORM = "wayland";
      QT_QML_GENERATE_QMLLS_INI = "ON";
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
    hyprpaper.enable = false;
    hyprpaper.settings = {
      ipc = "off";
      splash = false;
      splash_offset = 2.0;
      preload = [ "${./nixos-everforest.png}" ];
      wallpaper = [ "HDMI-A-1, ${./nixos-onedark.png}" ];
    };
    easyeffects.enable = true;
  };
  home.packages = [
    pkgs-unstable.helix
    pkgs-unstable.telegram-desktop
    pkgs-unstable.brave
    pkgs-unstable.prismlauncher
    pkgs.discord
    pkgs.usbimager
    pkgs.xkb-switch
    pkgs.xkblayout-state
    pkgs.libnotify
    pkgs.socat
    pkgs-staging.kdePackages.qtdeclarative
    pkgs.shotcut
    (inputs.quickshell.packages.${pkgs.system}.default.override {
      withJemalloc = true;
      withQtSvg = true;
      withWayland = true;
      withX11 = false;
      withPipewire = true;
      withPam = false;
      withHyprland = true;
      withI3 = false;
    })
  ];
# brave --enable-features=VaapiVideoDecoder,VaapiVideoEncoder,VaapiIgnoreDriverChecks,CanvasOopRasterization --ozone-platform-hint=x11

  
  programs = {
    fzf = {
      enable = true;
    };
    lutris = {
      enable = true;
    };
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
    cava = {
      enable = true;
    };
    obs-studio = {
      enable = true;

      plugins = with pkgs.obs-studio-plugins; [
        wlrobs
        obs-backgroundremoval
        obs-pipewire-audio-capture
        obs-vaapi
        obs-gstreamer
        obs-vkcapture
      ];
    };

    tmux = {
      enable = true;
      shortcut = "a";
      shell = "${pkgs.fish}/bin/fish";
      keyMode = "vi";
    };
    git = {
      enable = true;
    };
    home-manager = {
      enable = true;       
    };
    zellij = {
      enable = true;
      themes = {
        "everforest" = ./everforest-zellij.kdl;
      };
      settings = {
        theme = "everforest";
      };
    };
  };
}
