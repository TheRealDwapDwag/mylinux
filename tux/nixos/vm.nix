{ config, pkgs, ... }:

{
  
  # Enable dcont (System Management Tool)
  programs.dconf.enable = true;

  # Add user to libvirtd group
  users.users.w8.extraGroups = [ "libvirtd" ];

  # Install virtmanager and necessary pkgs
  environment.systemPackages = with pkgs; [
    virt-manager
    virt-viewer
    spice spice-gtk
    spice-protocol
    win-virtio
    win-spice
    gnome.adwaita-icon-theme
  ];
  
  # Manage the virtualization services
  virtualisation = {
    libvirtd ={
      enable = true;
      qemu = {
        swtpm.enable = true;
        ovmf.enable = true;
        ovmf.packages = [ pkgs.OVMFFull.fd ];
      };
    };
    spiceUSBRedirection.enable = true;
  };
  services.spice-vdagentd.enable = true;

}
