{ config, pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [
      catppuccin-nvim
    ];
    extraConfig = let
      luaRequire = module: builtins.readFile (builtins.toString
        ../extras/nvim + "/${module}.lua");
      luaConfig = builtins.concatStringsSep "\n" (map luaRequire [
        "init"
      ]);
    in ''
      lua << 
      ${luaConfig}
      
    '';
  };
}
