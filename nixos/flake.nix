{
  description = "w8's tux system flake";

  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-unstable";
      # 23.11-url = "github:nixos/nixpkgs/nixos-23.11"
      # random-url = "github:nixos/nixpkgs/HASH"
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
 
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    # flatpaks.url = "github:GermanBread/declarative-flatpak/stable";
    # Please DO NOT override the "nixpkgs" input!
    # Overriding "nixpkgs" is unsupported unless stated otherwise.
  };

  outputs = { 
    self, 
    nixpkgs,
    ...
    }@inputs: 
  let 
  inherit (self) outputs;
    system = [
    # "aarch64-linux"
    "x86_64-linux"
    ];
    # This is a function that generates an attribute by calling a function you
    # pass to it, with each system as an argument
    forAllSystems = nixpkgs.lib.genAttrs system;

    pkgs = import nixpkgs {
      inherit inputs system;

      config = {
        allowUnfree = true;
      };
    };

  in
  {
  
  # NixOS configuration entrypoint
    # Available through 'nixos-rebuild --flake .#your-hostname'
    nixosConfigurations = {
      # FIXME replace with your hostname
      tower = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs system;};
        modules = [
          # > Our main nixos configuration file < 
          ./nixos/hosts/tower/configuration.nix
        ];
      };
      macBook = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs system;};
        modules = [
          # > Our main nixos configuration file < 
          ./nixos/hosts/macBook/configuration.nix
        ];
      };
    };
    devShells.x86_64-linux.default = 
      pkgs.mkShell
        {
          nativeBuildInputs = with pkgs; [
            nodejs
          ];
        };
  };
}
