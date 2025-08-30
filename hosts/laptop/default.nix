{ config, lib, pkgs, pkgs-unstable, inputs,... }: {
  imports = [ 
    ./hardware-configuration.nix
    ../../modules/configuration.nix
  ];
  networking.hostName = "nixos_lp";
  hardware.cpu.amd.ryzen-smu.enable = true; 
  services = {
    power-profiles-daemon.enable = false;
    upower.enable = true;
    system76-scheduler.settings.cfsProfiles.enable = true;
    tlp = {
      enable = true;
      settings = {
        CPU_BOOST_ON_AC = 1;
        CPU_BOOST_ON_BAT = 0;
        CPU_SCALING_GOVERNOR_ON_AC = "performance";
        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
        CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
        CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
        CPU_DRIVER_OPMODE_ON_AC = "active";
        CPU_DRIVER_OPMODE_ON_BAT = "active";
        STOP_CHARGE_THRESH_BAT0 = 80;
        RADEON_DPM_STATE_ON_AC = "performance";
        RADEON_DPM_STATE_ON_BAT = "battery";
        RADEON_DPM_PERF_LEVEL_ON_AC = "high";
        RADEON_DPM_PERF_LEVEL_ON_BAT = "low";

      };
    };
  };
  #sudo ryzenadj --tctl-temp=75 --power-saving --fast-limit=10000 --slow-limit=10000 --stapm-limit=10000
  environment.systemPackages = [
    pkgs.ryzenadj
    pkgs.brightnessctl
  ];
}

