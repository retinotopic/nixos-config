{
  inputs = {
    nixpkgs.url = "https://flakehub.com/f/DeterminateSystems/nixpkgs-26.05-chilled/0.1";
    disko.url = "https://flakehub.com/f/nix-community/disko/1.13.0";  
    
    nixpkgs-unstable.url = "https://flakehub.com/f/DeterminateSystems/nixpkgs-weekly/0.1";
    # nixpkgs-staging.url = "github:nixos/nixpkgs/staging-next";
    
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
    wrappers = {
      url = "github:lassulus/wrappers";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    # helix-fork = {
    #   url = "github:gj1118/helix";
    #   inputs.nixpkgs.follows = "nixpkgs-unstable";
    # };
    hjem = {
      url = "github:feel-co/hjem";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
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
        # self.overlays.helixOverlay
      ];
    };
    lib = nixpkgs.lib;

    pkgs = {options ? self.pkgsOptions }: import nixpkgs options;

    specialArgs = {options ? self.pkgsOptions }: {
      pkgs-unstable = import nixpkgs-unstable options;
      inherit inputs;
    };

    overlays = {
      qsOverlay = final: prev: {
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
      # helixOverlay = final: prev: {
      #   helix = inputs.helix-fork.packages.${prev.system}.default; 
      # };
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
          inputs.hjem.nixosModules.default
        ];
      };
      laptop = lib.nixosSystem {
        pkgs = self.pkgs {};
        specialArgs = self.specialArgs {};
        modules = [
          ./hosts/laptop/default.nix
          ./hosts/laptop/disk-config.nix
          inputs.disko.nixosModules.disko
          inputs.hjem.nixosModules.default
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
