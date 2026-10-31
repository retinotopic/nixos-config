{ lib, config, pkgs, pkgs-unstable, inputs, ... }:
{
  imports = [
    ./configs/fuzzel.nix
    ./configs/fastfetch.nix
    ./configs/btop.nix
    ./configs/yazi.nix
    ./configs/nushell.nix
    ./configs/foot.nix
  ];

  options = {
    pkgs-wrapped = lib.mkOption {
      type = lib.types.attrsOf lib.types.package;
      default = {};
      description = "Packages built with wrappers";
    };
  };
  config = {
    hjem.users.retinotopic = {
      directory = "/home/retinotopic";

      files = {
        ".config/mitos".source = ./helix;

        "CuteShell".source = inputs.cuteshell;

        ".config/niri".source = ./niri;

        "nixos-everforest-light.png".source =
          ./nixos-everforest-light-outline.png;

        "nixos-everforest-dark.png".source =
          ./nixos-everforest-dark-outline.png;

        "nixos-onedark-onedark.png".source =
          ./nixos-onedark-onedark.png;
      };
    };
  };
}
