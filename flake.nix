{
  description = "Close to a perfect configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    darwin.url = "github:nix-darwin/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";

    # Stable
    # nixpkgs.url = github:NixOS/nixpkgs/nixpkgs-25.05-darwin;
    # home-manager.url = github:nix-community/home-manager/release-25.05;
  };

  outputs =
    inputs@{
      nixpkgs,
      home-manager,
      darwin,
      ...
    }:
    let
      overlay = system: final: prev: {
        neovim = nixpkgs.legacyPackages.${system}.neovim;
        neovim-unwrapped = nixpkgs.legacyPackages.${system}.neovim-unwrapped;
      };
    in
    {
      nixosConfigurations = {
        jachym = nixpkgs.lib.nixosSystem {
          system = "aarch64-linux";
          modules = [
            (
              { config, pkgs, ... }:
              {
                nixpkgs.overlays = [ (overlay "aarch64-linux") ];
              }
            )

            ./orb/configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.jachym = import ./home.nix;
            }
          ];
        };
      };

      homeConfigurations = {
        jachym = home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs {
            overlays = [ (overlay "x86_64-linux") ];
            system = "x86_64-linux";
          };
          modules = [
            ./home.nix
          ];
        };
      };

      darwinConfigurations."Jachyms-MacBook-Pro" = darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        modules = [
          home-manager.darwinModules.home-manager
          ./nix/darwin.nix
          {
            system.stateVersion = 5;
            nixpkgs.config.allowUnfree = true;
            nixpkgs.overlays = [
              (overlay "aarch64-darwin")
            ];

            home-manager.useGlobalPkgs = false;
            home-manager.useUserPackages = true;

            home-manager.users.jachym = {
              imports = [ ./home.nix ];
            };
          }
        ];
      };
    };
}
