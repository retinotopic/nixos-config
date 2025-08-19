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
    supportedSystems = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];
    forEachSupportedSystem = f: inputs.nixpkgs.lib.genAttrs supportedSystems (system: f {
      pkgs = import inputs.nixpkgs { inherit system; };
    });

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
          home-manager.useGlobalPkgs = true;
          home-manager.extraSpecialArgs = {
            inherit (specialArgs) pkgs-unstable;
            inherit inputs;
          };
        }
      ];
    };
    devShells = forEachSupportedSystem ({ pkgs }: {
      default = pkgs.mkShell {
        packages = with pkgs; [
          nixd
          nil
          cachix
          lorri
          niv
          nixfmt-classic
          statix
          vulnix
          haskellPackages.dhall-nix
          luajit
          lua-language-server
          go
          gopls
          golangci-lint
          gotools
        ];
      };
    });
  };
}
