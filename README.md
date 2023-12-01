# mylinux
My files for NixOS.

Still pretty new to NixOS and started linux journey at Feb 8th 2023 using linux mint, distro hopped between endeavourOS, Arch, Fedora, Rocky Linux and Gentoo until NixOS, where I dont't plan to hop other than for testing reasons.

I hope my files can be of use if needed because I know I will.

Check out Vimjoyer on YT for any help regarding NixOS.

Note to self: run 'sudo nix flake update' to update flake.nix and their flake.lock file for upgrading systems.

My flake.nix in ~/tux are impure since they reference ~/.config/home-manager. 
If using my config (for whatever reason) add an --impure at the end of the rebuild, e.g. 'sudo nixos-rebuild switch --flake ~/tux --impure'
