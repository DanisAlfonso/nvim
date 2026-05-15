-- snacks.nvim: dashboard and animations
vim.pack.add { 'https://github.com/folke/snacks.nvim' }
require('snacks').setup {
  explorer = {},
  dashboard = {
    enabled = true,
    preset = {
      header = '󰎜  nvim',
    },
    sections = {
      { section = 'header' },
      { section = 'keys', gap = 1, padding = 1 },
    },
  },
  animate = { enabled = true },
  indent = { enabled = true, animate = { enabled = true } },
  scroll = { enabled = true, animate = { enabled = true } },
  lazygit = {
    configure = true,
    config = {
      os = { editPreset = 'nvim-remote' },
      gui = { nerdFontsVersion = '3' },
    },
  },
  zen = {
    toggles = {
      dim = true,
      git_signs = false,
      mini_diff_signs = false,
    },
    show = {
      statusline = false,
      tabline = false,
    },
    win = {
      backdrop = { transparent = true },
    },
  },
  toggle = {
    which_key = true,
    notify = true,
    icon = {
      enabled = ' ',
      disabled = ' ',
    },
    color = {
      enabled = 'green',
      disabled = 'yellow',
    },
  },
  terminal = {
    win = { style = 'terminal' },
  },
  startup = { enabled = false },
}

-- Keymaps
vim.keymap.set('n', '<leader>e', function() Snacks.explorer() end, { desc = '[E]xplorer (snacks)' })
vim.keymap.set('n', '<leader>d', function() Snacks.dashboard() end, { desc = '[D]ashboard' })
vim.keymap.set('n', '<leader>gg', function() Snacks.lazygit() end, { desc = '[G]it [G]ui (lazygit)' })
vim.keymap.set('n', '<leader>gl', function() Snacks.lazygit.log() end, { desc = '[G]it [L]og (lazygit)' })
vim.keymap.set('n', '<leader>z', function() Snacks.zen() end, { desc = '[Z]en mode' })

-- Terminal keymaps
vim.keymap.set('n', '<leader>tt', function() Snacks.terminal.toggle() end, { desc = '[T]oggle [T]erminal' })
vim.keymap.set('n', '<leader>tf', function() Snacks.terminal.toggle(nil, { cwd = vim.fn.stdpath 'config' }) end, { desc = '[T]erminal [F]loe (nvim dir)' })
vim.keymap.set('n', '<leader>tl', function() Snacks.terminal.toggle('lazygit') end, { desc = '[T]erminal [L]azygit' })

-- Toggle keymaps
vim.keymap.set('n', '<leader>ud', function() Snacks.toggle.diagnostics() end, { desc = 'Toggle [D]iagnostics' })
vim.keymap.set('n', '<leader>ul', function() Snacks.toggle.line_number() end, { desc = 'Toggle [L]ine numbers' })
vim.keymap.set('n', '<leader>ui', function() Snacks.toggle.indent() end, { desc = 'Toggle [I]ndent guides' })
vim.keymap.set('n', '<leader>ut', function() Snacks.toggle.treesitter() end, { desc = 'Toggle [T]reesitter highlighting' })
vim.keymap.set('n', '<leader>uh', function() Snacks.toggle.inlay_hints() end, { desc = 'Toggle Inlay [H]ints' })
vim.keymap.set('n', '<leader>uw', function() Snacks.toggle.words() end, { desc = 'Toggle [W]ords highlighting' })
