return {
  "github/copilot.vim",
  config = function()
    -- Disable default tab mapping
    vim.g.copilot_no_tab_map = true
    vim.g.copilot_assume_mapped = true
    vim.g.copilot_tab_fallback = ""
    
    -- Use Ctrl-l to accept suggestion
    vim.keymap.set('i', '<C-l>', 'copilot#Accept("<CR>")', {
      expr = true,
      replace_keycodes = false
    })
    
    -- Use Ctrl-j and Ctrl-k to cycle through suggestions
    vim.keymap.set('i', '<C-j>', '<Plug>(copilot-next)')
    vim.keymap.set('i', '<C-k>', '<Plug>(copilot-previous)')
    
    -- Use Ctrl-h to dismiss suggestion
    vim.keymap.set('i', '<C-h>', '<Plug>(copilot-dismiss)')
  end,
} 