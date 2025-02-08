{ config, pkgs, ... }:


{
  imports = [
    ./configs/helix.nix
    ./configs/waybar.nix
    ./configs/hyprland.nix
  ];
  home.username = "retinotopic";
  home.homeDirectory = "/home/retinotopic";


  programs.git = {

    enable = true;

    userName = "retinotopic";

   userEmail = "retinotopic@proton.me";

  };

  home.stateVersion = "24.11";

  programs.home-manager.enable = true;

}
