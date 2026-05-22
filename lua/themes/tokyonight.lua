-- TokyoNight theme configuration
-- This file is used by lua/themes/init.lua (change the active theme there)

local M = {}

--- The colorscheme command to run (e.g. "tokyonight-day", "tokyonight-night", "tokyonight-storm")
M.colorscheme = "tokyonight-night"

--- Setup function called before the colorscheme command
M.setup = function()
  require("tokyonight").setup({
    style = "night",
    transparent = true,
    styles = {
      sidebars = "transparent",
      floats = "transparent",
    },
    on_colors = function(colors)
      colors.bg_statusline = "NONE"
    end,
    on_highlights = function(hl, c)
      hl.StatusLine = { fg = c.fg_sidebar, bg = "NONE" }
      hl.StatusLineNC = { fg = c.fg_gutter, bg = "NONE" }
    end,
  })
end

--- Lualine theme (nil = use built-in lualine theme for the colorscheme)
--- Set to a custom table to override, or leave nil to auto-detect
M.lualine_theme = nil
--- Lualine theme name (used when lualine_theme is nil; defaults to colorscheme)
M.lualine_theme_name = "tokyonight"

return M
