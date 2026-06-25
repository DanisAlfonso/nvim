-- moonfly theme configuration
-- This file is used by lua/themes/init.lua (change the active theme there)

local M = {}

--- The colorscheme command to run
M.colorscheme = "moonfly"

--- Setup function called before the colorscheme command
M.setup = function()
  -- Transparency: essential for Ghostty/WezTerm transparent backgrounds
  vim.g.moonflyTransparent = true

  -- Italic comments
  vim.g.moonflyItalics = true

  -- Terminal colors from the moonfly palette
  vim.g.moonflyTerminalColors = true

  -- Undercurls for spelling/lint errors
  vim.g.moonflyUndercurls = true

  -- Color the cursor
  vim.g.moonflyCursorColor = true

  -- WinSeparator style: 0=none, 1=block, 2=line
  vim.g.moonflyWinSeparator = 2

  -- After colorscheme loads, force transparency on groups
  -- that moonfly's native `moonflyTransparent` doesn't cover
  vim.api.nvim_create_autocmd('ColorScheme', {
    group = vim.api.nvim_create_augroup('MoonflyTransparentOverrides', { clear = true }),
    callback = function()
      -- Float / popup windows
      vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'NONE' })
      vim.api.nvim_set_hl(0, 'FloatBorder', { bg = 'NONE', fg = '#3c3c3c' })
      vim.api.nvim_set_hl(0, 'FloatTitle', { bg = 'NONE' })

      -- which-key uses its own highlight groups
      vim.api.nvim_set_hl(0, 'WhichKey', { bg = 'NONE' })
      vim.api.nvim_set_hl(0, 'WhichKeyGroup', { bg = 'NONE', fg = '#80a0ff' })
      vim.api.nvim_set_hl(0, 'WhichKeyDesc', { bg = 'NONE' })
      vim.api.nvim_set_hl(0, 'WhichKeySeperator', { bg = 'NONE' })
      vim.api.nvim_set_hl(0, 'WhichKeyFloat', { bg = 'NONE' })
      vim.api.nvim_set_hl(0, 'WhichKeyBorder', { bg = 'NONE', fg = '#3c3c3c' })

      -- Popup menu (used by blink.cmp)
      vim.api.nvim_set_hl(0, 'Pmenu', { bg = '#1c1c1c', fg = '#c6c6c6' })
      vim.api.nvim_set_hl(0, 'PmenuSel', { bg = '#323437', fg = '#e4e4e4' })
      vim.api.nvim_set_hl(0, 'PmenuSbar', { bg = '#1c1c1c' })
      vim.api.nvim_set_hl(0, 'PmenuThumb', { bg = '#444444' })

      -- Telescope
      vim.api.nvim_set_hl(0, 'TelescopeNormal', { bg = 'NONE' })
      vim.api.nvim_set_hl(0, 'TelescopeBorder', { bg = 'NONE', fg = '#3c3c3c' })
      vim.api.nvim_set_hl(0, 'TelescopeTitle', { bg = 'NONE' })
      vim.api.nvim_set_hl(0, 'TelescopePromptNormal', { bg = 'NONE' })
      vim.api.nvim_set_hl(0, 'TelescopePromptBorder', { bg = 'NONE', fg = '#3c3c3c' })
      vim.api.nvim_set_hl(0, 'TelescopeResultsNormal', { bg = 'NONE' })
      vim.api.nvim_set_hl(0, 'TelescopeResultsBorder', { bg = 'NONE', fg = '#3c3c3c' })
      vim.api.nvim_set_hl(0, 'TelescopePreviewNormal', { bg = 'NONE' })
      vim.api.nvim_set_hl(0, 'TelescopePreviewBorder', { bg = 'NONE', fg = '#3c3c3c' })
      vim.api.nvim_set_hl(0, 'TelescopePromptTitle', { bg = 'NONE' })
      vim.api.nvim_set_hl(0, 'TelescopeResultsTitle', { bg = 'NONE' })
      vim.api.nvim_set_hl(0, 'TelescopePreviewTitle', { bg = 'NONE' })

      -- snacks.nvim
      vim.api.nvim_set_hl(0, 'SnacksNormal', { bg = 'NONE' })
      vim.api.nvim_set_hl(0, 'SnacksFloat', { bg = 'NONE' })
      vim.api.nvim_set_hl(0, 'SnacksBorder', { bg = 'NONE', fg = '#3c3c3c' })

      -- nvim-tree / neo-tree explorers
      vim.api.nvim_set_hl(0, 'NvimTreeNormal', { bg = 'NONE' })
      vim.api.nvim_set_hl(0, 'NvimTreeVertSplit', { bg = 'NONE' })
      vim.api.nvim_set_hl(0, 'NeoTreeNormal', { bg = 'NONE' })
      vim.api.nvim_set_hl(0, 'NeoTreeNormalNC', { bg = 'NONE' })

      -- LSP / diagnostics floating windows
      vim.api.nvim_set_hl(0, 'DiagnosticFloating', { bg = 'NONE' })
      vim.api.nvim_set_hl(0, 'DiagnosticFloatingWarn', { bg = 'NONE' })
      vim.api.nvim_set_hl(0, 'DiagnosticFloatingError', { bg = 'NONE' })
      vim.api.nvim_set_hl(0, 'DiagnosticFloatingInfo', { bg = 'NONE' })
      vim.api.nvim_set_hl(0, 'DiagnosticFloatingHint', { bg = 'NONE' })

      -- notify / noice
      vim.api.nvim_set_hl(0, 'NotifyBackground', { bg = 'NONE' })

      -- dap-ui
      vim.api.nvim_set_hl(0, 'DapUIFloatBorder', { bg = 'NONE', fg = '#3c3c3c' })
      vim.api.nvim_set_hl(0, 'DapUIWindow', { bg = 'NONE' })
    end,
  })
end

--- Lualine theme — custom table to ensure transparency works
M.lualine_theme = function()
  return {
    normal = {
      a = { bg = '#323437', fg = '#c6c6c6', gui = 'bold' },
      b = { bg = '#212121', fg = '#949494' },
      c = { bg = 'NONE', fg = '#bdbdbd' },
    },
    insert = {
      a = { bg = '#8cc85f', fg = '#080808', gui = 'bold' },
      b = { bg = '#212121', fg = '#8cc85f' },
      c = { bg = 'NONE', fg = '#bdbdbd' },
    },
    visual = {
      a = { bg = '#e3c78a', fg = '#080808', gui = 'bold' },
      b = { bg = '#212121', fg = '#e3c78a' },
      c = { bg = 'NONE', fg = '#bdbdbd' },
    },
    command = {
      a = { bg = '#de935f', fg = '#080808', gui = 'bold' },
      b = { bg = '#212121', fg = '#de935f' },
      c = { bg = 'NONE', fg = '#bdbdbd' },
    },
    replace = {
      a = { bg = '#ff5d5d', fg = '#080808', gui = 'bold' },
      b = { bg = '#212121', fg = '#ff5d5d' },
      c = { bg = 'NONE', fg = '#bdbdbd' },
    },
    terminal = {
      a = { bg = '#79dac8', fg = '#080808', gui = 'bold' },
      b = { bg = '#212121', fg = '#79dac8' },
      c = { bg = 'NONE', fg = '#bdbdbd' },
    },
    inactive = {
      a = { bg = 'NONE', fg = '#949494', gui = 'bold' },
      b = { bg = 'NONE', fg = '#626262' },
      c = { bg = 'NONE', fg = '#626262' },
    },
  }
end
M.lualine_theme_name = nil

return M
