# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, pkgs-unstable, ... }:

{
  imports = [ 
        ./hardware-configuration.nix
  ];

  nix = {
    settings = {
      auto-optimise-store = true;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      extra-substituters = [
        "https://hyprland.cachix.org"
        "https://walker-git.cachix.org"
        "https://walker.cachix.org"
        "https://nix-gaming.cachix.org"
      ];
      extra-trusted-public-keys = [
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
        "walker-git.cachix.org-1:vmC0ocfPWh0S/vRAQGtChuiZBTAe4wiKDeyyXM0/7pM="
        "walker.cachix.org-1:fG8q+uAaMqhsMxWjwvk0IMb4mFPFLqHjuvfwQxE4oJM="
        "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="
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
  boot.extraModulePackages = with config.boot.kernelPackages ; [ amneziawg ] ;
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  time.timeZone = "Europe/Moscow";

  networking = {
    networkmanager.enable = true;  # Easiest to use and most distros use this by default.
    hostName = "nixos"; # Define your hostname.
    nameservers = [ "1.1.1.1#one.one.one.one" "1.0.0.1#one.one.one.one" ];
    firewall.allowedTCPPorts = [ 22 ];
  };

  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

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
    xserver.videoDrivers = ["nvidia"];
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
          path = "/etc/ssh/ssh_host_ed25519_key";
          rounds = 100;
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
  environment.systemPackages = with pkgs; [
    wget
    tree
    pkgs-unstable.helix
    fastfetch
    kitty
    byedpi
    pwvucontrol
    vlc
    ffmpeg
    streamlink
    docker-compose
    amneziawg-go
    pkgs-unstable.amneziawg-tools
    linuxKernel.packages.linux_zen.amneziawg # for zen amd cpus only
    mate.engrampa
    unrar
    unzip
    p7zip
    distrobox
    boxbuddy
    steam-run
    qbittorrent
    dysk
    xwayland-satellite
    nil
    nixd
    cachix
    lorri
    niv
    nixfmt-classic
    statix
    vulnix
    haskellPackages.dhall-nix
  ];

  environment.sessionVariables = {
    WLR_NO_HARDWARE_CURSORS = "1";
    NIXOS_OZONE_WL = "1";
  };

  hardware = {
    graphics = {
      extraPackages = with pkgs; [ nvidia-vaapi-driver vulkan-tools wgpu-utils ];
      enable = true;
    };
    nvidia = {
      modesetting.enable = true;
      open = false;
    };
  };
  
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal
    ];
    configPackages = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-hyprland
      pkgs.xdg-desktop-portal
    ];
  };

  virtualisation = {
    podman = {
      enable = true;
      # dockerCompat = true;
    };
    docker.enable = true;
    libvirtd.enable = true;
    docker.rootless = {
      enable = true;
      setSocketVariable = true;
    };
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

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "24.11"; # Did you read the comment?

}

