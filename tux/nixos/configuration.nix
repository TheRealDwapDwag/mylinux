# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ 
  config, 
  pkgs, 
  inputs,
  outputs,
  lib,
  ... 
}:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./vm.nix
      # <nixpkgs/nixos/modules/profiles/hardened.nix>
      inputs.home-manager.nixosModules.home-manager
    ];
  
  # Enable Backups (VERY IMPORTANT/USEFUL)
  # Disable if using flakes, since you likely have a repo and flake.lock"s"
  # system.copySystemConfiguration = true;
  
  # Hardening of NixOs
  # programs.firejail.enable = true;
  # programs.firejail.wrappedBinaries = {
    # firefox = {
      # executable = "${pkgs.lib.getBin pkgs.firefox}/bin/firefox";
      # profile = "${pkgs.firejail}/etc/firejail/firefox.profile";
    # };
  # };
  # services.clamav.daemon.enable = true;
  # services.clamav.updater.enable = true;

  nixpkgs = {
    config = {
      # Allow Unfree
      allowUnfree = true;
      allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
        "betterttv"
        "tokyo-night-v2"
      ];
      # Enable NUR
      packageOverrides = pkgs: {
        nur = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz") { inherit pkgs;
        };
      };
    };
  };

  # Nix Flakes * commands
  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      auto-optimise-store = true;
    };
    gc = {
      automatic = true;
      options = " --delete-older-than 14d";
    };
    optimise = {
      automatic = false;
      dates = [ "Weekly" ];
    };
  };

  # Boot Loader
  boot = {
    # Unfree Wifi drivers for macBook
    kernelModules = [ "wl" ];
    kernelPackages = pkgs.linuxPackages_latest;
    kernelParams = [ "acpi_osi=" ];
    extraModulePackages = [ config.boot.kernelPackages.broadcom_sta ];
    blacklistedKernelModules = [ "b43" "bcma" ];
    loader = {
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot"; # ← use the same mount point here.
      };
      grub = {
         enable = true;
         efiSupport = true;
         # efiInstallAsRemovable = true; # in case canTouchEfiVariables doesn't work for your system
         device = "nodev";
      };
    };
  };

  networking.hostName = "tux"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Australia/Sydney";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_AU.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_AU.UTF-8";
    LC_IDENTIFICATION = "en_AU.UTF-8";
    LC_MEASUREMENT = "en_AU.UTF-8";
    LC_MONETARY = "en_AU.UTF-8";
    LC_NAME = "en_AU.UTF-8";
    LC_NUMERIC = "en_AU.UTF-8";
    LC_PAPER = "en_AU.UTF-8";
    LC_TELEPHONE = "en_AU.UTF-8";
    LC_TIME = "en_AU.UTF-8";
  };
  
  # User
  users.users = { 
    w8 = {
      isNormalUser = true;
      home = "/home/w8";
      extraGroups = [ "wheel" "networkmanager" "homemanager" "nixbld" "video" "audio" ];
      #openssh.authorizedKeys.keys = [ "ssh-dss AAAAB3Nza... alice@foobar" ];
    };
  };

  # Home-Manager
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs; };
    users = {
      w8 = import /home/w8/.config/home-manager/home.nix;
    };
  };

  # Enable the X11 windowing system.
  services = {
    #Enables CUPS to print documents
    printing ={
      enable = true;
    };
    xserver = {
      enable = true;
      layout = "us";
      xkbVariant = "";
      # Enable the GNOME Desktop Environment
      displayManager = {
        sddm.enable = false;
      };
      desktopManager = {
	plasma5.enable = false;
      };
    };
    # Enable open ssh, config left as is for setup reasons, not security
    openssh ={
      enable = true;
      settings = {
        PermitRootLogin = "yes";
        PasswordAuthentication = true;
      };
    };
  };

  # Enable Hyprland
  programs.hyprland = {
    enable = true;
    # nvidiaPatches = true;
    xwayland.enable = true;
  };

  # Hint electron apps to use wayland:
  environment.sessionVariables = {
    WLR_NO_HARDWARE_CURSORS = "1";
    NIXOS_OZONE_WL = "1";
    ELECTRON_ENABLE_LOGGING = "1";
    WAYLAND_DEBUG = "1";
  };

  hardware = {
    pulseaudio.enable = false;
    opengl.enable = true;
    # nvidia.modesetting.enable = true;
  };

  #XDG Portal bs for Hyprland
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = with pkgs; [
      # xdg-desktop-portal-gtk
      # xdg-desktop-portal-wlr
      xdg-desktop-portal-hyprland
    ];
  };

  # Packages
  environment = {
    systemPackages = with pkgs; [
      # CLI tools
      gzip
      parted
      ripgrep
      unzip
      wget
      # Cosmic DE
      # cosmic-applets
      # cosmic-comp
      # cosmic-edit
      # cosmic-greeter
      # cosmic-icons
      # cosmic-panel
      # Development
      cargo
      git
      gcc
      gnumake
      lua
      rustc
      rustup
      vim
      # NixOS
      home-manager
      # Security
      tor-browser-bundle-bin
      # Recreational
      discord
      firefox
      # Rice/Desktop
      alacritty
      brightnessctl
      dunst
      eww
      hyprpaper
      grim
      kitty
      libsForQt5.polkit-kde-agent
      libnotify # Notifying agent, useful for discord
      networkmanagerapplet
      pavucontrol
      slurp
      wl-clipboard
      wofi
    ];
    plasma5.excludePackages = with pkgs.libsForQt5; [
      elisa
      okular
      oxygen
      khelpcenter
      konsole
    ];
  };
  #Fonts
  fonts.fonts = with pkgs; [
    font-awesome
    nerdfonts
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.bash.enableCompletion = true;
  programs.mtr.enable = true;
  programs.gnupg.agent = { enable = true; enableSSHSupport = true; };

  # Firewall
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 22 ];
    # allowedUDPPorts = [ ... ];
  };

  # Enable sound with pipewire.
  sound.enable = true;
  security.rtkit.enable = true;
  services = {
    dbus.enable = true;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };
  };

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOs release notes say you
  # should.
  system.stateVersion = "23.05"; # Did you read the comment?
}
