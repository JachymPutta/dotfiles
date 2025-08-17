-- Stolen from the obsidian.nvim readme
require("obsidian").setup({
  workspaces = {
    {
      name = "main",
      path = "~/Documents/obsidian",
    },
  },

  notes_subdir = "notes",

  daily_notes = {
    folder = "notes/dailies",
    date_format = "%Y-%m-%d",
    default_tags = { "daily-notes" },
    template = nil
  },

  completion = {
    nvim_cmp = true,
    min_chars = 2,
  },

  preferred_link_style = "wiki",
  disable_frontmatter = false,

  note_frontmatter_func = function(note)
    if note.title then
      note:add_alias(note.title)
    end
    local out = { id = note.id, aliases = note.aliases, tags = note.tags }
    if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
      for k, v in pairs(note.metadata) do
        out[k] = v
      end
    end

    return out
  end,

  templates = {
    folder = "templates",
    date_format = "%Y-%m-%d",
    time_format = "%H:%M",
  },

  follow_url_func = function(url)
    vim.fn.jobstart({ "open", url }) -- Mac OS
  end,

  follow_img_func = function(img)
    vim.fn.jobstart { "qlmanage", "-p", img } -- Mac OS quick look preview
  end,

  legacy_commands = false,

  picker = {
    name = "telescope.nvim",
  },

  sort_by = "modified",
  sort_reversed = true,
  search_max_lines = 1000,
  open_notes_in = "current",

  checkbox = {
    order = {
      -- NOTE: the 'char' value has to be a single character, and the highlight groups are defined below.
      [" "] = { char = "󰄱", hl_group = "ObsidianTodo" },
      ["x"] = { char = "", hl_group = "ObsidianDone" },
      -- [">"] = { char = "", hl_group = "ObsidianRightArrow" },
      -- ["~"] = { char = "󰰱", hl_group = "ObsidianTilde" },
      -- ["!"] = { char = "", hl_group = "ObsidianImportant" },
    },
  },

  ui = {
    enable = true,          -- set to false to disable all additional syntax features
    update_debounce = 200,  -- update delay after a text change (in milliseconds)
    max_file_length = 5000, -- disable UI features for files with more than this many lines
    bullets = { char = "•", hl_group = "ObsidianBullet" },
    external_link_icon = { char = "", hl_group = "ObsidianExtLinkIcon" },
    reference_text = { hl_group = "ObsidianRefText" },
    highlight_text = { hl_group = "ObsidianHighlightText" },
    tags = { hl_group = "ObsidianTag" },
    block_ids = { hl_group = "ObsidianBlockID" },
    hl_groups = {
      ObsidianTodo = { bold = true, fg = "#f78c6c" },
      ObsidianDone = { bold = true, fg = "#89ddff" },
      ObsidianRightArrow = { bold = true, fg = "#f78c6c" },
      ObsidianTilde = { bold = true, fg = "#ff5370" },
      ObsidianImportant = { bold = true, fg = "#d73128" },
      ObsidianBullet = { bold = true, fg = "#89ddff" },
      ObsidianRefText = { underline = true, fg = "#c792ea" },
      ObsidianExtLinkIcon = { fg = "#c792ea" },
      ObsidianTag = { italic = true, fg = "#89ddff" },
      ObsidianBlockID = { italic = true, fg = "#89ddff" },
      ObsidianHighlightText = { bg = "#75662e" },
    },
  },
})
