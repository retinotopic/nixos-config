# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, pkgs-unstable,pkgs-staging, inputs,... }:

{

  nix = {
    settings = {
      auto-optimise-store = true;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      extra-substituters = [
        "https://nix-community.cachix.org"
        "https://cache.nixos.org/"
        "https://hyprland.cachix.org"
      ];
      extra-trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      ];
    };
    
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };
  # Use the systemd-boot EFI boot loader.
  boot = {
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
  };
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  time.timeZone = "Europe/Moscow";

  networking = {
    networkmanager.enable = true;
    nftables.enable = true;
    nameservers = [ "1.1.1.1" "8.8.8.8" "1.0.0.1" "8.8.4.4" ];
    firewall.allowedTCPPorts = [ 22 ];
  };

  users.users.retinotopic = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "libvirtd" "docker" ];
  };
  
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    nerd-fonts.symbols-only
    noto-fonts-color-emoji
  ];
    
  services = {
    fstrim.enable = true;
    gvfs.enable = true;
    tumbler.enable = true;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
    resolved = { 
      enable = true;
      dnssec = "true";
      domains = [ "~." ];
      fallbackDns = [ "1.1.1.1#one.one.one.one" "1.0.0.1#one.one.one.one" ];
      dnsovertls = "true";
    };
    openssh = {
      enable = true;
      authorizedKeysInHomedir = true;
      settings = {
        PermitRootLogin = "without-password";
        PasswordAuthentication = false;
        # X11Forwarding = true;
      };
      hostKeys = [
        {
          bits = 4096;
          path = "/etc/ssh/ssh_host_ed25519_key";
          type = "ed25519";         
        }
      ];
      extraConfig = ''
        MaxStartups 5:50:10
        MaxSessions 1
      '';
    };
  };

  programs = {
    nekoray = {
      enable = true;
      tunMode.enable = true;
    };
    niri.enable = true;
    mosh.enable = true;
    virt-manager.enable = true;
    nix-ld.enable = true;
    steam.enable = true;
    appimage = {
      enable = true;
      binfmt = true;
    };
    vim.enable = true;
    git.enable = true;
    htop.enable = true;
    dconf.enable = true;
    chromium.enable = true;
    xwayland.enable = true;
    thunar = {
      enable = true;
      plugins = with pkgs.xfce; [
        thunar-archive-plugin
        thunar-volman
      ];
    };
  }; 
  environment.systemPackages = [
    pkgs.wget
    pkgs.bc
    pkgs.lm_sensors
    pkgs.tree
    pkgs.kitty
    pkgs.delta
    pkgs.byedpi
    pkgs.pwvucontrol
    pkgs.vlc
    pkgs.ffmpeg
    pkgs.scc
    pkgs.streamlink
    pkgs.docker-compose
    pkgs-unstable.amneziawg-tools
    pkgs.linuxKernel.packages.linux_zen.amneziawg # for zen amd cpus only
    pkgs.mate.engrampa
    pkgs.unrar
    pkgs.unzip
    pkgs.p7zip
    pkgs.distrobox
    pkgs.boxbuddy
    pkgs.steam-run
    pkgs.qbittorrent
    pkgs.dysk
    pkgs.xwayland-satellite
    pkgs.git-filter-repo
  ];

  environment.sessionVariables = {
    WLR_NO_HARDWARE_CURSORS = "1";
    NIXOS_OZONE_WL = "1";
  };

  hardware = {
    graphics = {
      enable = true;
    };
  };
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-wlr
      pkgs.xdg-desktop-portal
      pkgs.xdg-desktop-portal-termfilechooser
      pkgs.xdg-desktop-portal-hyprland
      pkgs.kdePackages.xdg-desktop-portal-kde
      pkgs.xdg-desktop-portal-xapp
    ];
    configPackages = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-hyprland
      pkgs.xdg-desktop-portal
    ];
  };

  virtualisation = {
    podman = {
      enable = false;
      # dockerCompat = true;
    };
    docker = {
      enable = true;
      daemon.settings = {
        dns = [ "1.1.1.1" "8.8.8.8" ];
        registry-mirrors = [ "https://mirror.gcr.io" ];
      };
      rootless = {
        enable = false;
        setSocketVariable = false;
      };
    };
    libvirtd.enable = true;
  };
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  system.stateVersion = "24.11"; # Did you read the comment?

}

