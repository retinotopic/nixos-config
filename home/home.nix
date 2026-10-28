{ lib,config, pkgs, pkgs-unstable, inputs, ... }:
{
  imports = [
    ./configs/foot.nix
    ./configs/fuzzel.nix
    ./configs/fish.nix

    ./configs/yazi.nix
    ./configs/fastfetch.nix
    ./configs/btop.nix
    ./configs/zed.nix
  ];
  
  home = {
    file = {
      ".config/helix" = {
        source = ./helix;
        recursive = true;        
      };
      "CuteShell" = {
        source = inputs.cuteshell;
        # source = "${inputs.cuteshell}";
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
    username = "aboba";
    homeDirectory = "/home/aboba";
    stateVersion = "24.11";
    
    pointerCursor = {
      enable = true;
      package = pkgs.lyra-cursors;
      name = "LyraF-cursors";
      size = 20;
    };
  };

  
  programs = {
    cava = {
      enable = true;
    };
    home-manager = {
      enable = true;       
    };
  };
}
