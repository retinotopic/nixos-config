{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs?ref=nixos-25.05";
    disko.url = "https://github.com/nix-community/disko/archive/v1.11.0.tar.gz";  
    
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixpkgs-staging.url = "github:nixos/nixpkgs/staging-next";
    
    home-manager = {
      url = "https://github.com/nix-community/home-manager/archive/release-25.05.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    quickshell = {
      url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
      inputs.nixpkgs.follows = "nixpkgs-staging";
    };
  
    cuteshell = {
      flake = false;
      url = "git+file:./home/CuteShell_submodule";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, nixpkgs-staging, ... }@inputs: rec { 
    supportedSystems = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];
    system = builtins.elemAt supportedSystems 0;
    pkgsChannelsOptions = { config.allowUnfree = true; inherit system; };
    lib = nixpkgs.lib;

    common = {
      pkgs = import nixpkgs pkgsChannelsOptions;
      specialArgs = {
        pkgs-unstable = import nixpkgs-unstable pkgsChannelsOptions;
        pkgs-staging = import nixpkgs-staging pkgsChannelsOptions;
        inherit inputs;
      };
    };

    forEachSupportedSystem = f: inputs.nixpkgs.lib.genAttrs
      supportedSystems (system: f common.pkgs );

    nixosConfigurations = {
      pc = lib.nixosSystem {
        inherit (common) pkgs specialArgs;
        modules = [
          ./hosts/pc/default.nix
          ./hosts/pc/disk-config.nix
          inputs.disko.nixosModules.disko
          ./modules/home-manager.nix
        ];
      };
      laptop = lib.nixosSystem {
        inherit (common) pkgs specialArgs;
        modules = [
          ./hosts/laptop/default.nix
          ./hosts/laptop/disk-config.nix
          inputs.disko.nixosModules.disko
          ./modules/home-manager.nix
        ];
      };
    };

    devShells = forEachSupportedSystem ({ pkgs,... }: {
      default = pkgs.mkShell {
        packages = with pkgs; [
          nixd
          nixfmt-rfc-style
          nil
        ];
      };
    });
  };
}
