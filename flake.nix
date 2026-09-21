{
  inputs = {
    nixpkgs.url = "https://flakehub.com/f/DeterminateSystems/nixpkgs-26.05-chilled/0.1";
    disko.url = "https://flakehub.com/f/nix-community/disko/1.13.0";  
    
    nixpkgs-unstable.url = "https://flakehub.com/f/DeterminateSystems/nixpkgs-weekly/0.1";
    # nixpkgs-staging.url = "github:nixos/nixpkgs/staging-next";
    
    home-manager = {
      url = "https://flakehub.com/f/nix-community/home-manager/0.2605.6835";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
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

    # REVIEW THOSE BEFORE UPDATING FLAKE LOCK FILE!!!!!!!!!!!!
    helium-flake = {
      url = "github:oxcl/nix-flake-helium-browser";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    happ-nix = {
      url = "github:DaHL-gh/happ-nix";
    };

  };

  outputs = { self, nixpkgs, nixpkgs-unstable, ... }@inputs: rec { 
    supportedSystems = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];
    system = builtins.elemAt supportedSystems 0;
    pkgsOptions = {
      config.allowUnfree = true;
      inherit system;
      overlays = [
        self.overlays.qsOverlay
        # self.overlays.karing
      ];
    };
    lib = nixpkgs.lib;

    pkgs = {options ? self.pkgsOptions }: import nixpkgs options;

    specialArgs = {options ? self.pkgsOptions }: {
      pkgs-unstable = import nixpkgs-unstable options;
      inherit inputs;
    };

    overlays.qsOverlay = final: prev: {
      quickshell = inputs.quickshell.packages.${prev.system}.default.override {
        withJemalloc = true;
        withQtSvg = true;
        withWayland = true;
        withX11 = false;
        withPipewire = true;
        withPam = true;
        withHyprland = true;
        withI3 = false;
      };
    };

    # overlays.karing = final: prev: {
    #   karing = prev.callPackage ./modules/karing.nix { };
    # };

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
