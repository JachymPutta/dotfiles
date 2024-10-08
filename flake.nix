{
  description = "Close to a perfect configuration";

  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs/24.05;
    nixpkgs_master.url = github:NixOS/nixpkgs;
    home-manager.url = github:nix-community/home-manager/release-24.05;
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    darwin.url = "github:lnl7/nix-darwin/master";
    darwin.inputs.nixpkgs.follows = "nixpkgs";

    ghostty.url = "git+ssh://git@github.com/ghostty-org/ghostty";

    # Vim plugins
    nest-nvim = {
      url = "github:lionc/nest.nvim";
      flake = false;
    };
    yazi-nvim = {
      url = "github:mikavilpas/yazi.nvim";
      flake = false;
    };
  };

  outputs = inputs@{ nixpkgs, nixpkgs_master, home-manager, darwin, ... }: 
    let
      overlay = 
        system: final: prev: {
          ghostty = inputs.ghostty.packages.${system}.default;
          vimPlugins = prev.vimPlugins // {
            nest-nvim = prev.vimUtils.buildVimPlugin {
              name = "nest.nvim";
              pname = "nest-nvim";
              src = inputs.nest-nvim;
            };
            yazi-nvim = prev.vimUtils.buildVimPlugin {
              name = "yazi.nvim";
              pname = "yazi-nvim";
              src = inputs.yazi-nvim;
            };
          };

          neovim = nixpkgs_master.legacyPackages.${system}.neovim;
          neovim-unwrapped = nixpkgs_master.legacyPackages.${system}.neovim-unwrapped;
        };
    in
  {
    nixosConfigurations = {
      jachym = nixpkgs.lib.nixosSystem {
        system = "aarch64-linux";
        modules = [
         ({ config, pkgs, ... }: { nixpkgs.overlays = [ (overlay "aarch64-linux")]; })

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
       jachym =
         home-manager.lib.homeManagerConfiguration {
           pkgs = import nixpkgs {overlays = [ (overlay "x86_64-linux")]; system = "x86_64-linux";};
           modules = [
              ./home.nix
           ];
        };
    };

    darwinConfigurations."Jachyms-MacBook-Pro" = darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        modules = [
          home-manager.darwinModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = false;
            home-manager.users.jachym = {
	      imports = [ ./home.nix ];
	    };
          }
          ./nix/darwin.nix
          {
            system.stateVersion = 5;
            nixpkgs.config.allowUnfree = true;
            nixpkgs.overlays = [ (overlay "aarch64-darwin")];
          }
        ];
      };

  };
}
