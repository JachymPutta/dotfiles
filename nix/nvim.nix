{ config, pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [
      catppuccin-nvim
      plenary-nvim
      telescope-nvim
      undotree

      # Convenience
      nvim-autopairs
      which-key-nvim
      zen-mode-nvim
      mini-nvim
      nvim-web-devicons

      # Lsp
      rustaceanvim
      rust-vim
      nvim-lspconfig
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
      copilot-lua
      copilot-cmp
      copilot-vim

      # Comments
      comment-nvim

      # NOTE: this doesn't work because of ocamllex
      # nvim-treesitter.withAllGrammars
      (nvim-treesitter.withPlugins
        # tree sitter with language support
        (
          plugins: with plugins; [
            tree-sitter-vim
            tree-sitter-lua
            tree-sitter-html
            tree-sitter-css
            tree-sitter-typst
            tree-sitter-markdown
            tree-sitter-bash
            tree-sitter-nix
            tree-sitter-rust
            tree-sitter-json
            tree-sitter-c
            tree-sitter-python
            tree-sitter-zig
            tree-sitter-ocaml
          ]
        )
      )
    ];
    extraConfig =
      let
        luaRequire = module: builtins.readFile (builtins.toString ../extras/nvim + "/${module}.lua");
        luaConfig = builtins.concatStringsSep "\n" (
          map luaRequire [
            "core/mappings"
            "core/init"
            "plugins/telescope"
            "plugins/treesitter"
            "plugins/lsp"
            "plugins/cmp"
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
