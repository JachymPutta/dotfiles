-- Set leader key
vim.g.mapleader = " "

-- Keymaps
require'nest'.applyKeymaps {
  { '<leader>', {
    { 'f', {
      { 'f', '<cmd> Telescope find_files <CR>' },
      { 'w', '<cmd> Telescope live_grep <CR>' },
      { 'o', '<cmd> Telescope oldfiles <CR>' },
      { 's', '<cmd> Telescope current_buffer_fuzzy_find <CR>' },
      { 'm', '<cmd> lua vim.lsp.buf.format { async = true } <CR>', "Format" },
      },
    },
    { 'u', '<cmd> UndotreeToggle <CR>' },
    { 'c', {
      { 'a', '<cmd> lua vim.lsp.buf.code_action() <CR>', "Code action" },
      { 'r', '<cmd> lua vim.diagnostic.open_float() <CR>', "Show full error" },
      },
    },
    { 'ra', '<cmd> lua vim.lsp.buf.rename() <CR>', "Rename" },
    { '/', '<cmd> lua require("Comment.api").toggle.linewise.current() <CR>', "Toggle comment" },
  },
  },
  { 'gd', '<cmd> lua vim.lsp.buf.definition() <CR>', "Go to definition" },
  { 'gD', '<cmd> lua vim.lsp.buf.declaration() <CR>', "Go to declaration" },
  { 'gi', '<cmd> lua vim.lsp.buf.implementation() <CR>', "Go to implementation" },
  { 'gr', '<cmd> lua vim.lsp.buf.references() <CR>', "Go to references" },
  { 'K', '<cmd> lua vim.lsp.buf.hover() <CR>', "Show hover" },
  { 'gs', '<cmd> lua vim.lsp.buf.signature_help() <CR>', "Show signature help" },

  { ';', ':', "enter command mode", options = { nowait = true } },
  { 'j', 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', "Move down", options = { expr = true } },
  { 'k', 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', "Move up", options = { expr = true } },
  { '<Esc>', '<cmd> noh <CR>', "Clear highlights" },
  { '<C-k>', ':wincmd k<CR>' },
  { '<C-j>', ':wincmd j<CR>' },
  { '<C-h>', ':wincmd h<CR>' },
  { '<C-l>', ':wincmd l<CR>' },
  { 'z', '<cmd>lua require("yazi").yazi()<CR>', "Open Yazi"};
  { mode = 'x', {
    { '<', '<gv' },
    { '>', '>gv' },
    { 'p', 'p:let @+=@0<CR>:let @"=@0<CR>', "Dont copy replaced text", opts = { silent = true } },
  }},
}

