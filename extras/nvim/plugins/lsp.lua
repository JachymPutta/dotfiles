local capabilities = require('cmp_nvim_lsp').default_capabilities()
local lspconfig = require 'lspconfig'

--- Use defaults for 'servers'
local servers = { "lua_ls", "html", "typst_lsp", "ruff_lsp", "pyright", "clangd" }
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    capabilities = capabilities,
  }
end

vim.g.rustfmt_autosave = 1
vim.g.rustaceanvim = {
  client = { server_capabilities = { inlayHintProvider = true } },
  tools = {
    autoSetHints = true,
    runnables = { use_telescope = true },
    inlay_hints = {

      only_current_line = false,
      only_current_line_autocmd = "CursorMoved",

      show_parameter_hints = true,

      parameter_hints_prefix = "<- ",
      other_hints_prefix = "=> ",

      max_len_align = false,

      max_len_align_padding = 1,

      right_align = false,

      right_align_padding = 7,
      highlight = "DiagnosticSignWarn",
    },
  },
}

require 'crates'.setup {}

require("copilot").setup({
  suggestion = { enabled = false },
  panel = { enabled = false },
})

require 'copilot_cmp'.setup {}
