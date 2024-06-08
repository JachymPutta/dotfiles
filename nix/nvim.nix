{ config, pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [
      catppuccin-nvim
      plenary-nvim
      telescope-nvim
      nest-nvim
    ];
    extraConfig = let
      luaRequire = module: builtins.readFile (builtins.toString
        ../extras/nvim + "/${module}.lua");
      luaConfig = builtins.concatStringsSep "\n" (map luaRequire [
        "core/mappings"
        "core/init"
        "plugins/telescope"
      ]);
    in ''
      lua << 
      ${luaConfig}
      
    '';
  };
}
