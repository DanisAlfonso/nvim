-- cyberdream.nvim theme configuration
-- This file is used by lua/themes/init.lua (change the active theme there)
--
-- "Transparency-first design" — all design decisions made with transparency in mind.
--
-- Variants: "default" (dark), "light"
-- Toggle between them with :CyberdreamToggleMode

local M = {}

--- The colorscheme command to run
M.colorscheme = "cyberdream"

--- Setup function called before the colorscheme command
M.setup = function()
  require("cyberdream").setup({
    transparent = true,
    variant = "default",
    italic_comments = true,
    terminal_colors = true,
    borderless_pickers = false,
    cache = false,

    extensions = {
      snacks = true,
      telescope = true,
      whichkey = true,
      blinkcmp = true,
      gitsigns = true,
      dashboard = true,
      noice = true,
      notify = true,
      treesitter = true,
      treesittercontext = true,
      dapui = true,
      indentblankline = true,
      rainbow_delimiters = true,
      trouble = true,
      lazy = true,
      mini = true,
      leap = true,
      -- disable what we don't use
      alpha = false,
      heirline = false,
      fzflua = false,
      cmp = false,
      hop = false,
      neogit = false,
      markdown = false,
      helpview = false,
      markview = false,
      grugfar = false,
      grapple = false,
      kubectl = false,
      gitpad = false,
    },
  })
end

--- Lualine theme (nil = use built-in lualine theme for the colorscheme)
M.lualine_theme = nil
--- Lualine theme name
M.lualine_theme_name = "cyberdream"

return M
