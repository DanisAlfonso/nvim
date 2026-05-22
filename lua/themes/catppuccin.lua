-- Catppuccin theme configuration
-- This file is used by lua/themes/init.lua (change the active theme there)
--
-- Flavours: catppuccin-latte (light), catppuccin-frappe, catppuccin-macchiato, catppuccin-mocha (dark)

local M = {}

--- The colorscheme command to run
--- Available: "catppuccin-nvim", "catppuccin-latte", "catppuccin-frappe",
---           "catppuccin-macchiato", "catppuccin-mocha"
M.colorscheme = "catppuccin-latte"

--- Setup function called before the colorscheme command
M.setup = function()
  require("catppuccin").setup({
    flavour = "auto", -- latte, frappe, macchiato, mocha
    background = {
      light = "latte",
      dark = "mocha",
    },
    transparent_background = true,
    float = {
      transparent = true,
      solid = false,
    },
    term_colors = false,
    dim_inactive = {
      enabled = false,
      shade = "dark",
      percentage = 0.15,
    },
    no_italic = false,
    no_bold = false,
    no_underline = false,
    styles = {
      comments = { "italic" },
      conditionals = { "italic" },
      loops = {},
      functions = {},
      keywords = {},
      strings = {},
      variables = {},
      numbers = {},
      booleans = {},
      properties = {},
      types = {},
      operators = {},
    },
    color_overrides = {},
    custom_highlights = {
      StatusLine = { bg = "NONE" },
      StatusLineNC = { bg = "NONE" },
    },
    default_integrations = true,
    auto_integrations = false,
    integrations = {
      cmp = true,
      gitsigns = true,
      telescope = true,
      notify = false,
      mini = {
        enabled = true,
        indentscope_color = "",
      },
    },
  })
end

--- Lualine theme (nil = use built-in lualine theme for the colorscheme)
--- Set to a custom table to override, or leave nil to auto-detect
M.lualine_theme = nil
--- Lualine theme name (used when lualine_theme is nil; defaults to colorscheme)
M.lualine_theme_name = "catppuccin-nvim"

return M
