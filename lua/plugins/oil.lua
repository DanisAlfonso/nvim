-- oil.nvim: file explorer as a normal buffer
-- https://github.com/stevearc/oil.nvim
vim.pack.add { 'https://github.com/stevearc/oil.nvim' }
require('oil').setup {
  default_file_explorer = true,
  view_options = {
    show_hidden = true,
  },
}
-- Open the parent directory of the current file
vim.keymap.set('n', '<leader>e', '<cmd>Oil<CR>', { desc = '[E]xplorer (oil)' })
-- Also keep - as a quick shortcut
vim.keymap.set('n', '-', '<cmd>Oil<CR>', { desc = 'Open parent directory (oil)' })
