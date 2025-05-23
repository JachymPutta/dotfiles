{ config, pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [
      # Base
      catppuccin-nvim
      plenary-nvim
      telescope-nvim
      undotree

      # Custom
      dailies-nvim
      obsidian-nvim

      # Convenience
      nvim-autopairs
      which-key-nvim
      mini-nvim
      nvim-web-devicons

      # Lsp
      nvim-dap
      crates-nvim

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
      # copilot-lua
      # copilot-cmp
      # copilot-vim

      # Comments
      comment-nvim

      nvim-treesitter.withAllGrammars
      # (nvim-treesitter.withPlugins
      #   # tree sitter with language support
      #   (
      #     plugins: with plugins; [
      #       tree-sitter-vim
      #       tree-sitter-lua
      #       tree-sitter-typst
      #       tree-sitter-markdown
      #       tree-sitter-bash
      #       tree-sitter-nix
      #       tree-sitter-rust
      #       tree-sitter-json
      #       tree-sitter-c
      #       tree-sitter-python
      #       tree-sitter-zig
      #       tree-sitter-ocaml
      #     ]
      #   )
      # )
    ];
    extraConfig =
      let
        luaRequire = module: builtins.readFile (builtins.toString ../extras/nvim + "/${module}.lua");
        luaConfig = builtins.concatStringsSep "\n" (
          map luaRequire [
            "core/mappings"
            "core/init"
            "plugins/cmp"
            "plugins/lsp"
            "plugins/obsidian"
            "plugins/telescope"
            "plugins/treesitter"
          ]
        );
      in
      ''
        lua << 
        ${luaConfig}
        
      '';
  };
}
