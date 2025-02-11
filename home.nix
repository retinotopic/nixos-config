{ config, pkgs, pkgs-unstable, ... }:


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
  };
  
  home.packages = with pkgs; [
    telegram-desktop
    pkgs-unstable.vivaldi
  ];
  
  programs = {
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
  };

}
