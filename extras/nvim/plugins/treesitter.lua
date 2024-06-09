require('nvim-treesitter.configs').setup {
  ensure_installed = {
    "vim",
    "lua",
    "html",
    "css",
    "javascript",
    "java",
    "typescript",
    "tsx",
    "c",
    "haskell",
    "markdown",
    "markdown_inline",
    "bash",
  },

  auto_install = true,

  highlight = {
    enable = true,
    use_languagetree = true,
    additional_vim_regex_highlighting = false,
  },

  indent = { enable = true },
}
