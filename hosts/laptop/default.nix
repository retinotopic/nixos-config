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
        CPU_BOOST_ON_AC = 0;
        CPU_BOOST_ON_BAT = 0;
        CPU_SCALING_GOVERNOR_ON_AC = "schedutil";
        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
        CPU_ENERGY_PERF_POLICY_ON_AC = "balance_performance";
        CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
        CPU_DRIVER_OPMODE_ON_AC = "guided";
        CPU_DRIVER_OPMODE_ON_BAT = "guided";
        STOP_CHARGE_THRESH_BAT0 = 80;
        RADEON_DPM_STATE_ON_AC = "balanced";
        RADEON_DPM_STATE_ON_BAT = "battery";
        RADEON_DPM_PERF_LEVEL_ON_AC = "auto";
        RADEON_DPM_PERF_LEVEL_ON_BAT = "auto";
        PLATFORM_PROFILE_ON_AC="balanced";
        PLATFORM_PROFILE_ON_BAT="low-power";
        WIFI_PWR_ON_AC="on";
        WIFI_PWR_ON_BAT="on";
        RUNTIME_PM_ON_AC="auto";
        RUNTIME_PM_ON_BAT="auto";
      };
    };
  };
  #sudo ryzenadj --tctl-temp=75 --power-saving --fast-limit=5000 --slow-limit=5000 --stapm-limit=5000
  environment.systemPackages = [
    pkgs.ryzenadj
    pkgs.brightnessctl
  ];
}

