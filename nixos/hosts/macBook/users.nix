{ config, pkgs, ... }:

{ 
  users.users = { 
    w8 = {
      isNormalUser = true;
      home = "/home/w8";
      extraGroups = [ "wheel" "networkmanager" "homemanager" "nixbld" "video" "audio" ];
      #openssh.authorizedKeys.keys = [ "ssh-dss AAAAB3Nza... alice@foobar" ];
    };
  };
}
