{ config, pkgs, inputs, outputs, lib, ...}:

{
  imports = [
    ./programs/alacritty.nix
    ./programs/firefox.nix
    ./programs/neovim.nix
  ];
}
