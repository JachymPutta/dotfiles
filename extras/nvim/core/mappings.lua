local wk = require("which-key")

wk.setup {
  delay = 0,
}

wk.add({
  { "<leader>/",  '<cmd>lua require("Comment.api").toggle.linewise.current()<CR>', desc = "Toggle Comment" },
  { "<leader>c",  group = "Code" },
  { "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>",                        desc = "Code Action" },
  { "<leader>cr", "<cmd>lua vim.diagnostic.open_float()<CR>",                      desc = "Show Diagnostics" },
  { "<leader>f",  group = "Find" },
  { "<leader>ff", "<cmd>Telescope find_files<CR>",                                 desc = "Find Files" },
  { "<leader>fm", "<cmd>lua vim.lsp.buf.format({ async = true })<CR>",             desc = "Format" },
  { "<leader>fo", "<cmd>Telescope oldfiles<CR>",                                   desc = "Recent Files" },
  { "<leader>fw", "<cmd>Telescope live_grep<CR>",                                  desc = "Live Grep" },
  { "<leader>ra", "<cmd>lua vim.lsp.buf.rename()<CR>",                             desc = "Rename" },
  { "<leader>u",  "<cmd>UndotreeToggle<CR>",                                       desc = "Toggle UndoTree" },
  { "<leader>z",  "<cmd>ZenMode<CR>",                                              desc = "Toggle ZenMode" },
  { "<leader>n",  group = "Notes" },
  { "<leader>nc", "<cmd>ObsidianNew<CR>",                                          desc = "Create Note" },
  { "<leader>nl", "<cmd>ObsidianLink<CR>",                                         desc = "Create Link" },
  { "<leader>ni", "<cmd>ObsidianLinkNew<CR>",                                      desc = "Insert Link to Note" },
  { "<leader>nw", "<cmd>ObsidianSearch<CR>",                                       desc = "Search in Notes" },
  { "<leader>nd", "<cmd>Dailies<CR>",                                              desc = "Create Daily" },
})

wk.add({
  { ";",     ":",                                            desc = "Command Mode" },
  { "<C-d>", "<C-d>zz",                                      desc = "Scroll Down Centered" },
  { "<C-h>", "<cmd>wincmd h<CR>",                            desc = "Window Left" },
  { "<C-j>", "<cmd>wincmd j<CR>",                            desc = "Window Down" },
  { "<C-k>", "<cmd>wincmd k<CR>",                            desc = "Window Up" },
  { "<C-l>", "<cmd>wincmd l<CR>",                            desc = "Window Right" },
  { "<C-u>", "<C-u>zz",                                      desc = "Scroll Up Centered" },
  { "<Esc>", "<cmd>nohlsearch<CR>",                          desc = "Clear Highlights" },
  { "K",     "<cmd>lua vim.lsp.buf.hover()<CR>",             desc = "Hover Documentation" },
  { "N",     "Nzzzv",                                        desc = "Previous Search Result" },
  { "gD",    "<cmd>lua vim.lsp.buf.declaration()<CR>",       desc = "Go to Declaration" },
  { "gd",    "<cmd>lua vim.lsp.buf.definition()<CR>",        desc = "Go to Definition" },
  { "gi",    "<cmd>lua vim.lsp.buf.implementation()<CR>",    desc = "Go to Implementation" },
  { "gr",    "<cmd>lua vim.lsp.buf.references()<CR>",        desc = "Go to References" },
  { "gs",    "<cmd>lua vim.lsp.buf.signature_help()<CR>",    desc = "Signature Help" },
  { "j",     "v:count || mode(1)[0:1] == 'no' ? 'j' : 'gj'", desc = "Move Down",             expr = true, replace_keycodes = false },
  { "k",     "v:count || mode(1)[0:1] == 'no' ? 'k' : 'gk'", desc = "Move Up",               expr = true, replace_keycodes = false },
  { "n",     "nzzzv",                                        desc = "Next Search Result" },
})

wk.add({
  mode = { "x" },
  { "<", "<gv",                           desc = "Indent Left" },
  { ">", ">gv",                           desc = "Indent Right" },
  { "p", 'p:let @+=@0<CR>:let @"=@0<CR>', desc = "Paste without overwriting" },
})
