{ config, pkgs, ... }:


{
  imports = [
    ./configs/helix.nix
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
