{
  description = "Close to a perfect configuration";

  inputs = {
    # Stable
    # nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-24.11-darwin";
    # home-manager.url = "github:nix-community/home-manager/release-24.11";
    # darwin.url = "github:nix-darwin/nix-darwin/nix-darwin-24.11";
    # Unstable
    nixpkgs.url = "github:NixOS/nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    darwin.url = "github:nix-darwin/nix-darwin";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    darwin.inputs.nixpkgs.follows = "nixpkgs";
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
      };
    in
    {
      nixosConfigurations = {
        jachym = nixpkgs.lib.nixosSystem {
          system = "aarch64-linux";
          pkgs = import nixpkgs {
            overlays = [ (overlay "x86_64-linux") ];
            system = "x86_64-linux";
            config.allowUnfree = true;
          };
          modules = [
            ./orb/configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
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
        pkgs = import nixpkgs {
          overlays = [ (overlay "aarch64-darwin") ];
          system = "aarch64-darwin";
          config.allowUnfree = true;
        };
        modules = [
          home-manager.darwinModules.home-manager
          ./nix/darwin.nix
          {
            system.stateVersion = 5;
            home-manager.useGlobalPkgs = true;
            home-manager.users.jachym = {
              imports = [ ./home.nix ];
            };
          }
        ];
      };
    };
}
