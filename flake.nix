{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs/24.05;
    home-manager.url = github:nix-community/home-manager/release-24.05;
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    ghostty = {
      url = "git+ssh://git@github.com/ghostty-org/ghostty";
    };

    nest-nvim = {
      url = "github:lionc/nest.nvim";
      flake = false;
    };
  };

  outputs = inputs@{ nixpkgs, home-manager, ... }: 
    let
      system = "x86_64-linux";
      overlay = 
        final: prev: {
          ghostty = inputs.ghostty.packages.${system}.default;
          vimPlugins = prev.vimPlugins // {
            nest-nvim = prev.vimUtils.buildVimPlugin {
              name = "nest.nvim";
              pname = "nest-nvim";
              src = inputs.nest-nvim;
            };
          };
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

