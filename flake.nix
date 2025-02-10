{
  description = "my nixos flake";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs?ref=nixos-24.11";
    disko.url = "https://github.com/nix-community/disko/archive/master.tar.gz";   
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "https://github.com/nix-community/home-manager/archive/release-24.11.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, ... }@inputs: let 
    system = "x86_64-linux";
    pkgs-unstable = nixpkgs-unstable.legacyPackages.${system};
  in {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {

      inherit system;
      specialArgs = { inherit pkgs-unstable; };
      
      modules = [
        inputs.home-manager.nixosModules.home-manager
        ./configuration.nix
        inputs.disko.nixosModules.disko
        ./disk-config.nix
      ];
    };
  };
}
