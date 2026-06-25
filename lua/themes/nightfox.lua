-- nightfox.nvim theme configuration
-- This file is used by lua/themes/init.lua (change the active theme there)
--
-- Variants (set M.colorscheme):
--   "nightfox"   — dark blue-gray
--   "dayfox"     — light
--   "dawnfox"    — warm light
--   "duskfox"    — darker, more muted
--   "nordfox"    — nord-inspired
--   "terafox"    — earthy
--   "carbonfox"  — grayscale

local M = {}

--- The colorscheme command to run
M.colorscheme = "carbonfox"

--- Setup function called before the colorscheme command
M.setup = function()
  require("nightfox").setup({
    options = {
      transparent = true,
      terminal_colors = true,
      dim_inactive = false,
      styles = {
        comments = "italic",
        keywords = "bold",
        types = "italic",
      },
    },
  })
end

--- Lualine theme (nil = use built-in lualine theme for the colorscheme)
M.lualine_theme = nil
--- Lualine theme name
M.lualine_theme_name = "nightfox"

return M
