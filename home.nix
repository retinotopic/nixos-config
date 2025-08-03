{ lib,config, pkgs, pkgs-unstable, inputs, ... }:
{
  imports = [
    ./configs/waybar.nix
    ./configs/hyprland.nix
    ./configs/foot.nix
    ./configs/yazi.nix
    ./configs/fuzzel.nix
    ./configs/fish.nix
    ./configs/fastfetch.nix
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
    };
    tmux = {
      enable = true;
      shortcut = "a";
      shell = "${pkgs.fish}/bin/fish";
      keyMode = "vi";
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
