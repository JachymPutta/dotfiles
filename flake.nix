{
  description = "Close to a perfect configuration";

  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs/24.05;
    nixpkgs_master.url = github:NixOS/nixpkgs;
    home-manager.url = github:nix-community/home-manager/release-24.05;
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    ghostty = {
      url = "git+ssh://git@github.com/ghostty-org/ghostty";
    };

    # Vim plugins
    nest-nvim = {
      url = "github:lionc/nest.nvim";
      flake = false;
    };
  };

  outputs = inputs@{ nixpkgs, nixpkgs_master, home-manager, ... }: 
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
          neovim = nixpkgs_master.legacyPackages.${system}.neovim;
          neovim-unwrapped = nixpkgs_master.legacyPackages.${system}.neovim-unwrapped;
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

     homeConfigurations = {
       jachym =
         home-manager.lib.homeManagerConfiguration {
           pkgs = import nixpkgs {overlays = [ overlay ]; system = "x86_64-linux";};
           modules = [
              ./home.nix
           ];
        };
    };
  };
}
