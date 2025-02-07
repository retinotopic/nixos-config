{
  description = "my nixos flake";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs?ref=nixos-unstable";
    disko.url = "https://github.com/nix-community/disko/archive/master.tar.gz";   
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, ... }@inputs: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        inputs.home-manager.nixosModules.home-manager
        ./configuration.nix
         inputs.disko.nixosModules.disko
        ./disk-config.nix
      ];
    };
  };
}
