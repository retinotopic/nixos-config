{ config, lib, pkgs, pkgs-unstable, inputs,... }: {
  imports = [ 
    ./hardware-configuration.nix
    ../../modules/configuration.nix
  ];
  
  services = {
    xserver.videoDrivers = ["nvidia"];
  };
  networking.hostName = "nixos_pc";

  hardware = {
    graphics = {
      extraPackages = with pkgs; [ nvidia-vaapi-driver vulkan-tools wgpu-utils ];
    };
    nvidia = {
      modesetting.enable = true;
      open = false;
    };
  };
}
