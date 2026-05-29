-- which-key: shows pending keybinds in a popup
local gh = require('helpers').gh
vim.pack.add { gh('folke/which-key.nvim') }
local wk = require 'which-key'

wk.setup {
  delay = 0,
  icons = {
    mappings = vim.g.have_nerd_font,
    -- Rules to automatically assign icons based on keymap patterns
    rules = {
      -- Plugin-based icons
      { plugin = 'gitsigns', icon = ' ' },
      { plugin = 'neo-tree', icon = ' ' },
      { plugin = 'telescope', icon = ' ' },
      { plugin = 'which-key', icon = ' ' },
      { plugin = 'snacks', icon = ' ' },
      { plugin = 'oil', icon = ' ' },
      { plugin = 'conform', icon = ' ' },
      -- Mode-based icons
      { mode = 'n', icon = ' ' },
      { mode = 'v', icon = ' ' },
    },
  },
  preset = 'helix',
  spec = {
    -- Search group
    { '<leader>s', group = 'Search', icon = ' ', mode = { 'n', 'v' } },
    -- Toggle group
    { '<leader>t', group = 'Toggle', icon = ' ' },
    -- UI Toggle group
    { '<leader>u', group = 'UI Toggle', icon = ' ' },
    -- Git group (both h for hunk and g for general git)
    { '<leader>h', group = 'Git Hunk', icon = ' ', mode = { 'n', 'v' } },
    { '<leader>g', group = 'Git', icon = ' ' },
    -- LSP group
    { 'gr', group = 'LSP Actions', icon = ' ', mode = { 'n' } },
    -- Dashboard
    { '<leader>d', desc = 'Dashboard', icon = ' ' },
    -- Zen mode
    { '<leader>z', desc = 'Zen mode', icon = ' ' },
    -- Oil / Explorer
    { '<leader>o', desc = 'Oil explorer', icon = ' ' },
    { '-', desc = 'Open parent (oil)', icon = ' ' },
    { '<leader>e', desc = 'Explorer (snacks)', icon = ' ' },
  },
}
