-- Set basic options
vim.opt.number = true            -- Show line numbers
vim.opt.hlsearch = false         -- Disable search highlighting
vim.opt.expandtab = true         -- Use spaces instead of tabs
vim.opt.tabstop = 2              -- Number of spaces tabs count for
vim.opt.shiftwidth = 2           -- Number of spaces for each indentation
vim.opt.termguicolors = true     -- Enable true color support

-- Change colorscheme
vim.cmd([[colorscheme catppuccin]])

-- Simple status line
vim.opt.statusline = "%f %h%m%r%=%-14.(%l,%c%V%) %P"
