{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs?ref=nixos-25.05";
    disko.url = "https://github.com/nix-community/disko/archive/v1.11.0.tar.gz";  
    
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    
    home-manager = {
      url = "https://github.com/nix-community/home-manager/archive/release-25.05.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    quickshell = {
      url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = { self, nixpkgs, nixpkgs-unstable, ... }@inputs: let 
    system = "x86_64-linux";

    specialArgs = {
      pkgs-unstable = import nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true;
      };
      inherit inputs;
    };
    supportedSystems = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];
    forEachSupportedSystem = f: inputs.nixpkgs.lib.genAttrs supportedSystems (system: f {
      pkgs = import nixpkgs { inherit system; };
    });
    lib = nixpkgs.lib;
  in {
    nixosConfigurations = {
      pc = lib.nixosSystem {
        inherit specialArgs;
        modules = [
          ./hosts/pc/default.nix
          ./hosts/pc/disk-config.nix
          inputs.disko.nixosModules.disko
          { nixpkgs.config.allowUnfree = true; }
          ./modules/home-manager.nix
        ];
      };
      laptop = lib.nixosSystem {
        inherit specialArgs;
        modules = [
          ./hosts/laptop/default.nix
          ./hosts/laptop/disk-config.nix
          inputs.disko.nixosModules.disko
          { nixpkgs.config.allowUnfree = true; }
          ./modules/home-manager.nix
        ];
      };
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
