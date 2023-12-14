{ config, pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    shellAliases = {
      ll = "ls -l";
      update = "sudo nixos-rebuild switch --flake `~/tux";
    };
    histSize = 10000;
    histFile = "${config.xdg.dataHome}/zsh/history";
  };
}
