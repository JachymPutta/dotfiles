-- Set basic options
vim.loader.enable(true)
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "number"
vim.g.mapleader = " "

vim.opt.hlsearch = false                             -- Disable search highlighting
vim.opt.expandtab = true                             -- Use spaces instead of tabs
vim.opt.tabstop = 2                                  -- Number of spaces tabs count for
vim.opt.shiftwidth = 2                               -- Number of spaces for each indentation
vim.opt.termguicolors = true                         -- Enable true color support
vim.opt.ignorecase = true                            -- Ignore case when searching
vim.opt.smartcase = true                             -- Ignore case if search pattern is all lowercase
vim.opt.undofile = true                              -- Enable persistent undo
vim.opt.statusline = "%f %h%m%r%=%-14.(%l,%c%V%) %P" -- Set statusline
vim.opt_local.spell = true                           -- Enable spell checking
vim.opt_local.spelllang = 'en_us'                    -- Set spell checking language
vim.o.winborder = 'rounded'

vim.opt.conceallevel = 1

--
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.colorcolumn = "80"

-- Change colorscheme
vim.cmd([[colorscheme catppuccin]])

-- Flag to check if clipboard has been set
local clipboard_set = false
-- Autocmd to set clipboard to use the system clipboard on first file open
vim.api.nvim_create_autocmd("BufRead", {
  callback = function()
    if not clipboard_set then
      vim.opt.clipboard:append("unnamedplus")
      clipboard_set = true
    end
  end
})

-- Copy over ssh
vim.g.clipboard = {
  name = 'OSC 52',
  copy = {
    ['+'] = require('vim.ui.clipboard.osc52').copy('+'),
    ['*'] = require('vim.ui.clipboard.osc52').copy('*'),
  },
  paste = {
    ['+'] = require('vim.ui.clipboard.osc52').paste('+'),
    ['*'] = require('vim.ui.clipboard.osc52').paste('*'),
  },
}

-- Rust lsp directory
-- With big projects it's better to keep the compilation and lsp
-- directories separate, run this in the root fo the project
-- export CARGO_TARGET_DIR='$proj_root/target_dirs/rustc
-- vim.fn.setenv("CARGO_TARGET_DIR", "target_dirs/ra")


-- Autocmd to format on save
vim.api.nvim_create_autocmd("BufWritePre", {
  callback = function()
    vim.lsp.buf.format { async = false }
  end
})

-- Enable persistent undo
vim.opt.undodir = vim.fn.expand('~/.config/nvim/undodir')
local undodir = vim.fn.expand('~/.config/nvim/undodir')
if not vim.fn.isdirectory(undodir) then
  vim.fn.mkdir(undodir, 'p')
end
