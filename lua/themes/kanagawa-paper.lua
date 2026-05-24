-- Kanagawa Paper theme configuration
-- This file is used by lua/themes/init.lua (change the active theme there)
--
-- Variants: "kanagawa-paper-ink" (dark), "kanagawa-paper-canvas" (light)
-- Colorscheme command: "kanagawa-paper" (auto based on vim.o.background)

local M = {}

--- The colorscheme command to run
--- Available: "kanagawa-paper", "kanagawa-paper-ink", "kanagawa-paper-canvas"
M.colorscheme = "kanagawa-paper"

--- Setup function called before the colorscheme command
M.setup = function()
  require("kanagawa-paper").setup({
    undercurl = true,
    transparent = true,
    gutter = false,
    diag_background = true,
    dim_inactive = false,
    terminal_colors = true,
    cache = false,
    styles = {
      comment = { italic = true },
      functions = { italic = false },
      keyword = { italic = false, bold = false },
      statement = { italic = false, bold = false },
      type = { italic = false },
    },
    colors = {
      palette = {},
      theme = {
        ink = {},
        canvas = {},
      },
    },
    color_balance = {
      ink = { brightness = 0, saturation = 0 },
      canvas = { brightness = 0, saturation = 0 },
    },
    overrides = function(colors)
      return {
        StatusLine = { bg = "NONE" },
        StatusLineNC = { bg = "NONE" },
        NormalFloat = { bg = "none" },
        FloatBorder = { bg = "none" },
        FloatTitle = { bg = "none" },
      }
    end,
    auto_plugins = true,
    all_plugins = false,
  })
end

--- Lualine theme (nil = use built-in lualine theme for the colorscheme)
--- Set to a custom table to override, or leave nil to auto-detect
M.lualine_theme = function()
  local colors = require("kanagawa-paper.colors").setup()
  local theme = colors.theme
  return {
    normal = {
      a = { bg = theme.modes.normal, fg = theme.ui.bg_m3 },
      b = { bg = theme.ui.bg_p2, fg = theme.modes.normal },
      c = { bg = "none", fg = theme.ui.fg_dim },
    },
    insert = {
      a = { bg = theme.modes.insert, fg = theme.ui.bg_m3 },
      b = { bg = theme.ui.bg_p2, fg = theme.modes.insert },
      c = { bg = "none", fg = theme.ui.fg_dim },
    },
    visual = {
      a = { bg = theme.modes.visual, fg = theme.ui.bg_m3 },
      b = { bg = theme.ui.bg_p2, fg = theme.modes.visual },
      c = { bg = "none", fg = theme.ui.fg_dim },
    },
    command = {
      a = { bg = theme.modes.command, fg = theme.ui.bg_m3 },
      b = { bg = theme.ui.bg_p2, fg = theme.modes.command },
      c = { bg = "none", fg = theme.ui.fg_dim },
    },
    replace = {
      a = { bg = theme.modes.replace, fg = theme.ui.bg_m3 },
      b = { bg = theme.ui.bg_p2, fg = theme.modes.replace },
      c = { bg = "none", fg = theme.ui.fg_dim },
    },
    terminal = {
      a = { bg = theme.modes.terminal, fg = theme.ui.bg_m3 },
      b = { bg = theme.ui.bg_p2, fg = theme.modes.terminal },
      c = { bg = "none", fg = theme.ui.fg_dim },
    },
    inactive = {
      a = { bg = "none", fg = theme.modes.normal },
      b = { bg = "none", fg = theme.ui.fg_dim, gui = "bold" },
      c = { bg = "none", fg = theme.ui.fg_dim },
    },
  }
end
--- Lualine theme name (used when lualine_theme is nil; defaults to colorscheme)
M.lualine_theme_name = "kanagawa-paper-ink"  -- base name; actual variant depends on vim.o.background

return M
