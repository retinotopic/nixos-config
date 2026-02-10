{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs?ref=nixos-25.11";
    disko.url = "https://github.com/nix-community/disko/archive/v1.11.0.tar.gz";  
    
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    # nixpkgs-staging.url = "github:nixos/nixpkgs/staging-next";
    
    home-manager = {
      url = "https://github.com/nix-community/home-manager/archive/release-25.11.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    quickshell = {
      url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
  
    cuteshell = {
      flake = false;
      # url = "./home/CuteShell_submodule";
      # url = "path:./home/CuteShell_submodule";
      url = "git+file:./home/CuteShell_submodule?submodules=1";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, ... }@inputs: rec { 
    supportedSystems = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];
    system = builtins.elemAt supportedSystems 0;
    pkgsOptions = { config.allowUnfree = true; inherit system; };
    lib = nixpkgs.lib;

    pkgs = {options ? self.pkgsOptions }: import nixpkgs options;

    specialArgs = {options ? self.pkgsOptions }: {
      pkgs-unstable = import nixpkgs-unstable options;
      inherit inputs;
    };
    

    forEachSupportedSystem = f: inputs.nixpkgs.lib.genAttrs
      supportedSystems (system: f {
        pkgs = (pkgs {options = pkgsOptions // {inherit system;}; });
        specialArgs = (specialArgs {options = pkgsOptions // {inherit system;}; });
      });

    nixosConfigurations = {
      pc = lib.nixosSystem {
        pkgs = self.pkgs {};
        specialArgs = self.specialArgs {};
        modules = [
          ./hosts/pc/default.nix
          ./hosts/pc/disk-config.nix
          inputs.disko.nixosModules.disko
          ./modules/home-manager.nix
        ];
      };
      laptop = lib.nixosSystem {
        pkgs = self.pkgs {};
        specialArgs = self.specialArgs {};
        modules = [
          ./hosts/laptop/default.nix
          ./hosts/laptop/disk-config.nix
          inputs.disko.nixosModules.disko
          ./modules/home-manager.nix
        ];
      };
    };
    devShells = forEachSupportedSystem ({ pkgs,specialArgs }: {
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
