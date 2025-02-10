{ config, pkgs, ... }:


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
  
  home.packages = with pkgs; [
    telegram-desktop
  ];
  
  programs = {
    git = {
      enable = true;
      userName = "retinotopic";
      userEmail = "retinotopic@proton.me";
    };
    # helix = {
      # enable = true;
    # };
    btop.enable = true;
    foot.enable = true;
    yazi.enable = true;
    home-manager = {
      enable = true;       
    }; 
  };

}
