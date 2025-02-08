{
  description = "my nixos flake";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs?ref=nixos-24.11";
    disko.url = "https://github.com/nix-community/disko/archive/master.tar.gz";   
    home-manager = {
      url = "https://github.com/nix-community/home-manager/archive/release-24.11.tar.gz";
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
