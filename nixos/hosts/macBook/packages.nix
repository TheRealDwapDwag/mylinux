{config, pkgs, ... }:

{
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
      git
      vim
        # C
        gcc
        gnumake
        # Go
        libcap
        go
        # Haskell
        # Lua
        lua
        # LLVM
        # Rust
        cargo
        rustc
        rustup
      # General
      ffmpeg
      mesa
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
  };
}
