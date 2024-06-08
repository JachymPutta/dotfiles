-- Set leader key
vim.g.mapleader = " "

-- Set basic options
vim.opt.number = true            -- Show line numbers
vim.opt.relativenumber = true    -- Relative line numbers
vim.opt.hlsearch = false         -- Disable search highlighting
vim.opt.expandtab = true         -- Use spaces instead of tabs
vim.opt.tabstop = 4              -- Number of spaces tabs count for
vim.opt.shiftwidth = 4           -- Number of spaces for each indentation
vim.opt.termguicolors = true     -- Enable true color support

-- Change colorscheme
vim.cmd([[colorscheme catppuccin]])

-- Simple status line
vim.opt.statusline = "%f %h%m%r%=%-14.(%l,%c%V%) %P"

-- Use ctrl-[hjkl] to select the active split
vim.api.nvim_set_keymap('n', '<C-k>', ':wincmd k<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-j>', ':wincmd j<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-h>', ':wincmd h<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-l>', ':wincmd l<CR>', { noremap = true, silent = true })
