{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { nixpkgs, nixpkgs-unstable, ... }:
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
            ./common-configuration.nix
            ./desktop-configuration.nix
          ];
          specialArgs = {
            inherit pkgs-unstable;
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
