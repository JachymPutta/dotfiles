-- Set leader key
vim.g.mapleader = " "

-- Use ctrl-[hjkl] to select the active split
vim.api.nvim_set_keymap('n', '<C-k>', ':wincmd k<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-j>', ':wincmd j<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-h>', ':wincmd h<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-l>', ':wincmd l<CR>', { noremap = true, silent = true })

local nest = require 'nest'

nest.applyKeymaps {
  { '<leader>', {
    { 'f', {
      { 'f', '<cmd> Telescope find_files <CR>' },
      { 'w', '<cmd> Telescope live_grep <CR>' },
      { 'o', '<cmd> Telescope oldfiles <CR>' },
      },
    { 'th', '<cmd> Telescope themes <CR>' },
    }},
  }
}

--  ["<leader>ff"] = { "<cmd> Telescope find_files <CR>", "Find files" },
--  ["<leader>fa"] = { "<cmd> Telescope find_files follow=true no_ignore=true hidden=true <CR>", "Find all" },
--  ["<leader>fw"] = { "<cmd> Telescope live_grep <CR>", "Live grep" },
--  ["<leader>fb"] = { "<cmd> Telescope buffers <CR>", "Find buffers" },
--  ["<leader>fh"] = { "<cmd> Telescope help_tags <CR>", "Help page" },
--  ["<leader>fo"] = { "<cmd> Telescope oldfiles <CR>", "Find oldfiles" },
--  ["<leader>fz"] = { "<cmd> Telescope current_buffer_fuzzy_find <CR>", "Find in current buffer" },

--  -- git
--  ["<leader>cm"] = { "<cmd> Telescope git_commits <CR>", "Git commits" },
--  ["<leader>gt"] = { "<cmd> Telescope git_status <CR>", "Git status" },

--  -- pick a hidden term
--  ["<leader>pt"] = { "<cmd> Telescope terms <CR>", "Pick hidden term" },

--  -- theme switcher
--  ["<leader>th"] = { "<cmd> Telescope themes <CR>", "Nvchad themes" },

--  ["<leader>ma"] = { "<cmd> Telescope marks <CR>", "telescope bookmarks" },
--
