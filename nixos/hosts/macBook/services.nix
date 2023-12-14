{ config, pkgs, ... }:

{
  services = {
    #Enables CUPS to print documents
    printing ={
      enable = true;
    };
    xserver = {
      enable = true;
      layout = "us";
      xkbVariant = "";
    };
    # Enable open ssh, config left as is for setup reasons, not security
    openssh = {
      enable = true;
      settings = {
        PermitRootLogin = "yes";
        PasswordAuthentication = true;
      };
    };
  };
}
