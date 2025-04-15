vim.lsp.config('*', {
  root_markers = { '.git', '.hg' },
})

vim.lsp.config('clangd', {
  cmd = { 'clangd', '--background-index' },
  root_markers = { 'compile_commands.json', 'compile_flags.txt' },
  filetypes = { 'c', 'cpp' },
})

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

vim.lsp.config('html', {
  capabilities = capabilities,
  root_markers = { 'index.html' },
  filetypes = { 'html' },
})


vim.lsp.config('luals', {
  cmd = { 'lua-language-server' },
  filetypes = { 'lua' },
  root_markers = { '.git', '.luarc.json', '.luarc.jsonc' },
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
      }
    }
  }
})

vim.lsp.config('ocamllsp', {
  cmd = { 'ocamllsp' },
  root_markers = { 'dune-project' },
  filetypes = { 'ocaml' },
})

vim.lsp.config('pyright', {
  cmd = { 'pyright' },
  root_markers = { 'setup.py', 'requirements.txt' },
  filetypes = { 'python' },
})

vim.lsp.config('ruff', {
  cmd = { 'ruff' },
  root_markers = { 'setup.py', 'requirements.txt' },
  filetypes = { 'python' },
})

vim.lsp.config('rust-analyzer', {
  cmd = { 'rust-analyzer' },
  root_markers = { '.git', 'Cargo.toml' },
  filetypes = { 'rust' },
})

vim.lsp.config('tinymist', {
  cmd = { 'tinymist' },
  filetypes = { 'typst' },
})

vim.lsp.config('zls', {
  cmd = { 'zls' },
  root_markers = { 'build.zig' },
  filetypes = { 'zig' },
})

vim.lsp.enable({
  "clangd",
  "html",
  "luals",
  "ocamllsp",
  "pyright",
  "ruff",
  "rust-analyzer",
  "tinymist",
  "zls",
})

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if client:supports_method('textDocument/completion') then
      vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
    end
  end,
})

vim.cmd("set completeopt+=noselect")

require("crates").setup()

-- require("copilot").setup({
--   suggestion = { enabled = false },
--   panel = { enabled = false },
-- })
-- require("copilot_cmp").setup()
