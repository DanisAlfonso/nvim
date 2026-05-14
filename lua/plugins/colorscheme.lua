-- Rose Pine colorscheme with transparency
vim.pack.add { 'https://github.com/rose-pine/neovim' }
---@diagnostic disable-next-line: missing-fields
require('rose-pine').setup {
  ---@diagnostic disable-next-line: missing-fields
  highlight_groups = {
    ColorColumn = { bg = 'rose' },
    Normal = { bg = 'NONE' },
    NormalFloat = { bg = 'NONE' },
  },
  styles = {
    bold = true,
    italic = false,
    transparency = true,
  },
}
vim.cmd.colorscheme 'rose-pine'
