vim.lsp.config('*', {
  capabilities = {
    workspace = {
      didChangeWatchedFiles = {
        dynamicRegistration = true,
      },
    },
    textDocument = {
      completion = {
        completionItem = {
          snippetSupport = true,
          resolveSupport = {
            properties = {
              'documentation',
              'detail',
              'additionalTextEdits',
            },
          },
        },
      },
    },
  },
  flags = {
    debounce_text_changes = 150,
  },
  root_markers = { '.git' },
})

vim.lsp.config('clangd', {
  cmd = { 'clangd', '--background-index' },
  root_markers = { 'compile_commands.json', 'compile_flags.txt' },
  filetypes = { 'c', 'cpp' },
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


vim.lsp.config('html', {
  cmd = { 'vscode-html-language-server', '--stdio' },
  filetypes = { 'html', 'templ' },
  root_markers = { 'package.json', '.git' },
  settings = {},
  init_options = {
    provideFormatter = true,
    embeddedLanguages = { css = true, javascript = true },
    configurationSection = { 'html', 'css', 'javascript' },
  },
})

local function set_python_path(path)
  local clients = vim.lsp.get_clients {
    bufnr = vim.api.nvim_get_current_buf(),
    name = 'pyright',
  }
  for _, client in ipairs(clients) do
    if client.settings then
      client.settings.python = vim.tbl_deep_extend('force', client.settings.python, { pythonPath = path })
    else
      client.config.settings = vim.tbl_deep_extend('force', client.config.settings, { python = { pythonPath = path } })
    end
    client.notify('workspace/didChangeConfiguration', { settings = nil })
  end
end

vim.lsp.config('pyright', {
  cmd = { "pyright-langserver", "--stdio" },
  root_markers = {
    'pyproject.toml',
    'setup.py',
    'setup.cfg',
    'requirements.txt',
    'Pipfile',
    'pyrightconfig.json',
  },
  filetypes = { 'python' },
  settings = {
    pyright = {
      -- Using Ruff's import organizer
      disableOrganizeImports = true,
    },
    python = {
      analysis = {
        -- Ignore all files for analysis to exclusively use Ruff for linting
        ignore = { '*' },
      },
    },
  },
  on_attach = function(client, bufnr)
    vim.api.nvim_buf_create_user_command(bufnr, 'LspPyrightOrganizeImports', function()
      client:exec_cmd({
        command = 'pyright.organizeimports',
        arguments = { vim.uri_from_bufnr(bufnr) },
      })
    end, {
      desc = 'Organize Imports',
    })
    vim.api.nvim_buf_create_user_command(bufnr, 'LspPyrightSetPythonPath', set_python_path, {
      desc = 'Reconfigure pyright with the provided python path',
      nargs = 1,
      complete = 'file',
    })
  end,
})

vim.lsp.config('ruff', {
  cmd = { 'ruff', 'server' },
  root_markers = {
    'setup.py',
    'pyproject.toml',
    'ruff.toml',
    '.ruff.toml',
    'requirements.txt',
  },
  filetypes = { 'python' },
  init_options = {
    settings = {
      configurationPreference = 'filesystemFirst',
      fixAll = true,
      organizeImports = true,
      lint = {
        enable = true,
        preview = true,
      },
      format = {
        preview = true,
      },
    },
  },
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
--
-- vim.lsp.config('ocamllsp', {
--   cmd = { 'ocamllsp' },
--   root_markers = { 'dune-project' },
--   filetypes = { 'ocaml' },
-- })
