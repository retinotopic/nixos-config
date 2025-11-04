{ config, pkgs, lib, inputs, pkgs-unstable, pkgs-staging, ... }:
{
  imports = [ inputs.home-manager.nixosModules.home-manager ];

  home-manager.users.retinotopic = import ../home/home.nix;
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;

  home-manager.extraSpecialArgs = {
    inherit inputs pkgs-unstable pkgs-staging;
  };
}
