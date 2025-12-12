{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    zen-browser-flake = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, nixpkgs-unstable, zen-browser-flake, ... }:
    # { nixpkgs, home-manager, ... }:
    let
      system = "x86_64-linux";
      # pkgs = nixpkgs.legacyPackages.${system};
      pkgs-unstable = nixpkgs-unstable.legacyPackages.${system};
    in
    {
      nixosConfigurations = {
        
        # Desktop configuration
        hp-laptop = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            ./zen-browser.nix
            ./common-configuration.nix
            ./desktop-configuration.nix
          ];
          specialArgs = {
            inherit pkgs-unstable;
            inherit zen-browser-flake;
          };
        };

        # Server configuration
        server = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            ./common-configuration.nix
            ./server-configuration.nix
          ];
          specialArgs = {
            inherit pkgs-unstable;
          };
        };

      };
    };
}
