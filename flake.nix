{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { nixpkgs, ... }:
    # { nixpkgs, home-manager, ... }:
    let
      system = "x86_64-linux";
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
        };

        # Server configuration
        server = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            ./common-configuration.nix
            ./server-configuration.nix
          ];
        };

      };
    };
}
