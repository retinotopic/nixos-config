{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs?ref=nixos-25.05";
    disko.url = "https://github.com/nix-community/disko/archive/v1.11.0.tar.gz";  
    
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    
    home-manager = {
      url = "https://github.com/nix-community/home-manager/archive/release-25.05.tar.gz";
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
        { pkgs.config.allowUnfree = true; }
        
        home-manager.nixosModules.home-manager 
        {
          home-manager.users = {
            retinotopic = import ./home.nix;
          };
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = {
            inherit (specialArgs) pkgs-unstable;
            inherit inputs;
          };
        }
      ];
    };
  };
}
