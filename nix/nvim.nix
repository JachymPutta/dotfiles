{ config, pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [
      catppuccin-nvim
      plenary-nvim
      telescope-nvim
      nest-nvim

      # Lsp
      rustaceanvim
      nvim-lspconfig
      nvim-dap

      #Typst 
      typst-vim

      #nvim-treesitter.withAllGrammars
      (nvim-treesitter.withPlugins
        # tree sitter with language support
        (plugins:
          with plugins; [
            tree-sitter-vim
            tree-sitter-lua
            tree-sitter-html
            tree-sitter-css
            tree-sitter-javascript
            tree-sitter-java
            tree-sitter-typescript
            tree-sitter-typst
            tree-sitter-tsx
            tree-sitter-haskell
            tree-sitter-markdown
            tree-sitter-markdown_inline
            tree-sitter-bash
            tree-sitter-nix
            tree-sitter-rust
            tree-sitter-json
            tree-sitter-c
            tree-sitter-go
            tree-sitter-hcl
          ]))
    ];
    extraConfig = let
      luaRequire = module: builtins.readFile (builtins.toString
        ../extras/nvim + "/${module}.lua");
      luaConfig = builtins.concatStringsSep "\n" (map luaRequire [
        "core/mappings"
        "core/init"
        "plugins/telescope"
        "plugins/treesitter"
        "plugins/lsp"
      ]);
    in ''
      lua << 
      ${luaConfig}
      
    '';
  };
}
