{ config, lib, pkgs, pkgs-unstable, inputs,... }: {
  imports = [ 
    ./hardware-configuration.nix
    ../../modules/configuration.nix
  ];
  networking.hostName = "nixos_lp";
  
  services = {
    upower.enable = true;
    system76-scheduler.settings.cfsProfiles.enable = true;
    power-profiles-daemon.enable = true;
  };
  environment.systemPackages = [
    pkgs.ryzenadj
  ];
}

