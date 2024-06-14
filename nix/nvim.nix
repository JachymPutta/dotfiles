{ config, pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [
      catppuccin-nvim
      plenary-nvim
      telescope-nvim
      yazi-nvim
      nest-nvim
      undotree
      nvim-autopairs

      # Lsp
      rustaceanvim
      nvim-lspconfig
      nvim-dap

      # Autocomplete
      cmp-nvim-lsp
      nvim-cmp
      cmp-vsnip
      cmp-buffer

      vim-vsnip
      vim-vsnip-integ

      #Typst 
      typst-vim

      # Copilot
      copilot-lua
      copilot-cmp
      copilot-vim
      # codeium-nvim //NOTE: unfree license, deal with it later

      # Comments
      comment-nvim
      nvim-treesitter.withAllGrammars

      # (nvim-treesitter.withPlugins
      #   # tree sitter with language support
      #   (plugins:
      #     with plugins; [
      #       tree-sitter-vim
      #       tree-sitter-lua
      #       tree-sitter-html
      #       tree-sitter-css
      #       tree-sitter-javascript
      #       tree-sitter-java
      #       tree-sitter-typescript
      #       tree-sitter-typst
      #       tree-sitter-tsx
      #       tree-sitter-haskell
      #       tree-sitter-markdown
      #       tree-sitter-markdown_inline
      #       tree-sitter-bash
      #       tree-sitter-nix
      #       tree-sitter-rust
      #       tree-sitter-json
      #       tree-sitter-c
      #       tree-sitter-go
      #       tree-sitter-hcl
      #       tree-sitter-python
      #     ]))
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
        "plugins/cmp"
      ]);
    in ''
      lua << 
      ${luaConfig}
      
    '';
  };
}
