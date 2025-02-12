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

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, ... }@inputs: let 
    system = "x86_64-linux";

    specialArgs = {
      pkgs-unstable = import nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true;
      };
    };
    
  in {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      inherit specialArgs;
      modules = [
      
        ./configuration.nix
        inputs.disko.nixosModules.disko
        ./disk-config.nix
        { nixpkgs.config.allowUnfree = true; }
        
        home-manager.nixosModules.home-manager 
        {
          home-manager.users = {
            retinotopic = import ./home.nix;
          };
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = { inherit (specialArgs) pkgs-unstable; };
        }
      ];
    };
  };
}
