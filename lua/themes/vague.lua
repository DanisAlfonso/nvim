-- Vague theme configuration
-- This file is used by lua/themes/init.lua (change the active theme there)
--
-- Colorscheme command: "vague"
-- Has built-in lualine theme at lualine/themes/vague.lua

local M = {}

--- The colorscheme command to run
M.colorscheme = "vague"

--- Setup function called before the colorscheme command
M.setup = function()
  require("vague").setup({
    transparent = true,
    bold = true,
    italic = true,
    on_highlights = function(hl, colors)
      hl.StatusLine = { bg = "NONE" }
      hl.StatusLineNC = { bg = "NONE" }
      hl.NormalFloat = { bg = "none" }
      hl.FloatBorder = { bg = "none" }
      hl.FloatTitle = { bg = "none" }
    end,
  })
end

--- Lualine theme (nil = use built-in lualine theme for the colorscheme)
--- Set to a custom table to override, or leave nil to auto-detect
M.lualine_theme = nil
--- Lualine theme name (used when lualine_theme is nil; defaults to colorscheme)
M.lualine_theme_name = "vague"

return M
