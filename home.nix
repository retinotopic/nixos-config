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
      # ".config/helix".source = config.lib.file.mkOutOfStoreSymlink "/home/retinotopic/nixos-config/helix";
    };
      
    username = "retinotopic";
    homeDirectory = "/home/retinotopic";
    stateVersion = "24.11";
  };
  
  services = {
    hyprpaper.enable = true;
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
  ];
# brave --proxy-server="socks5://127.0.0.1:1080" --enable-features=VaapiVideoDecoder,VaapiVideoEncoder,VaapiIgnoreDriverChecks,CanvasOopRasterization --ozone-platform-hint=x11

  
  programs = {
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
    direnv = {
      enable = true;
      nix-direnv.enable = true;
      enableBashIntegration = false;
      enableNushellIntegration = false;
      enableZshIntegration = false;
    };
    fish.enable = true;
    btop.enable = true;
    foot.enable = true;
    yazi.enable = true;
    home-manager = {
      enable = true;       
    }; 
  };

}
