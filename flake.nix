{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs/24.05;
    home-manager.url = github:nix-community/home-manager/release-24.05;
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    ghostty = {
      url = "git+ssh://git@github.com/ghostty-org/ghostty";
    };
  };

  outputs = inputs@{ nixpkgs, home-manager, ... }: 
    let
      system = "x86_64-linux";
      overlay = 
        final: prev: {
          ghostty = inputs.ghostty.packages.${system}.default;
        };
    in
  {
    nixosConfigurations = {
      jachym = nixpkgs.lib.nixosSystem {
        system = system;
        modules = [
         ({ config, pkgs, ... }: { nixpkgs.overlays = [ overlay ]; })

          ./configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.jachym = import ./home.nix;
          }
        ];
      };
    };
  };
}

