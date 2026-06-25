-- nordic.nvim theme configuration
-- This file is used by lua/themes/init.lua (change the active theme there)

local M = {}

--- The colorscheme command to run
M.colorscheme = "nordic"

--- Setup function called before the colorscheme command
M.setup = function()
  require("nordic").setup({
    transparent = {
      bg = true,    -- transparent editor background
      float = true, -- transparent floating windows (which-key, telescope, etc.)
    },
    bold_keywords = false,
    italic_comments = true,
    bright_border = false,
    reduced_blue = true,
    swap_backgrounds = false,
    cursorline = {
      bold = false,
      bold_number = true,
      theme = 'dark',
      blend = 0.85,
    },
    visual = {
      bold = false,
      bold_number = true,
      theme = 'dark',
      blend = 0.85,
    },
    integrations = {
      which_key = true,
      telescope = true,
      blink_cmp = true,
      gitsigns = true,
      dashboard = true,
      noice = true,
      notify = true,
      neo_tree = true,
      nvim_dap = true,
      trouble = true,
      treesitter = true,
      treesitter_context = true,
      rainbow_delimiters = true,
      indent_blankline = true,
      leap = true,
      lazy = true,
      mini = true,
    },
    telescope = { style = 'flat' },
    noice = { style = 'classic' },
  })
end

--- Lualine theme (nil = use built-in lualine theme for the colorscheme)
M.lualine_theme = nil
--- Lualine theme name
M.lualine_theme_name = "nordic"

return M
