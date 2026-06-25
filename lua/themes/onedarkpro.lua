-- onedarkpro theme configuration
-- This file is used by lua/themes/init.lua (change the active theme there)
--
-- Variants (set M.colorscheme):
--   "onedark"       — standard One Dark
--   "onedark_vivid" — more saturated
--   "onedark_dark"  — darker variant
--   "vaporwave"     — pastel / synthwave tones

local M = {}

--- The colorscheme command to run
M.colorscheme = "onedark_dark"

--- Setup function called before the colorscheme command
M.setup = function()
  require("onedarkpro").setup({
    -- Other variants are available via M.colorscheme below
    theme = "onedark",

    options = {
      -- Transparency: essential for Ghostty/WezTerm transparent backgrounds
      transparency = true,
      -- Transparent lualine center section
      lualine_transparency = true,
      -- Use theme's terminal colors
      terminal_colors = true,
      -- Don't dim inactive windows (doesn't play well with transparency)
      highlight_inactive_windows = false,
    },

    plugins = {
      -- All plugins enabled by default; only disabling what conflicts
    },
  })
end

--- Lualine theme (nil = use built-in lualine theme for the colorscheme)
--- With lualine_transparency=true in options, the built-in theme handles it.
M.lualine_theme = nil
--- Lualine theme name (used when lualine_theme is nil; defaults to colorscheme)
M.lualine_theme_name = "onedark"

return M
