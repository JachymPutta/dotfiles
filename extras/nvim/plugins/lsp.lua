require'lspconfig'.typst_lsp.setup{}
-- require'copilot'.setup {
--   suggestion = {
--     enabled = true,
--     auto_trigger = true,
--   },
--   panel = {
--     enabled = true,
--     auto_refresh = true,
--     keymap = {
--       jump_prev = "<C-p>",
--       jump_next = "<C-n>",
--       accept = "<CR>",
--     },
--   },
-- }

require("copilot").setup({
  suggestion = { enabled = false },
  panel = { enabled = false },
})
require'copilot_cmp'.setup {}


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

local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- TODO: clean this up, put it into a forloop or something
require'lspconfig'.rust_analyzer.setup {
  capabilities = capabilities
}

require'lspconfig'.copilot.setup {
  cmd = { 'Copilot' },
  event = "InsertEnter",
  capabilities = capabilities,
  config = function()
	require("copilot").setup({
	  suggestion = { enabled = false },
	  panel = { enabled = false },
	})
  end,
}


