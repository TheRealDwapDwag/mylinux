{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
    btop
    efibootmgr
    neofetch
    tor-browser-bundle-bin
    waybar
    ranger
    discord
    # eww
    # nerdfonts.override { fonts = [ "Iosevka" ]; } # Install specific nerdfont package
  ];
}
