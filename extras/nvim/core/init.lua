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

-- Rust lsp directory
-- With big projects it's better to keep the compilation and lsp
-- directories separate, run this in the root fo the project
-- export CARGO_TARGET_DIR='$proj_root/target_dirs/rustc
vim.fn.setenv("CARGO_TARGET_DIR", "target_dirs/ra")


