{ config, pkgs, ... }:

{
  imports = [
    ./shell/bash.nix
    ./shell/zsh.nix
  ];
}
