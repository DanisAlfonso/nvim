-- snacks.nvim: dashboard and animations
local gh = require('helpers').gh
vim.pack.add { gh('folke/snacks.nvim') }
require('snacks').setup {
  explorer = {
    replace_netrw = true,
  },
  dashboard = {
    enabled = true,
    preset = {
      header = '  NVIM',
      keys = {
        { icon = ' ', key = 'f', desc = 'Find File', action = ':lua Snacks.dashboard.pick(\'files\')' },
        { icon = ' ', key = 'n', desc = 'New File', action = ':ene | startinsert' },
        { icon = ' ', key = 'g', desc = 'Find Text', action = ':lua Snacks.dashboard.pick(\'live_grep\')' },
        { icon = ' ', key = 'r', desc = 'Recent Files', action = ':lua Snacks.dashboard.pick(\'oldfiles\')' },
        { icon = ' ', key = 'c', desc = 'Config', action = ':e $MYVIMRC' },
        { icon = '󰒲 ', key = 'L', desc = 'Lazy', action = ':Lazy', enabled = package.loaded.lazy ~= nil },
        { icon = ' ', key = 'q', desc = 'Quit', action = ':qa' },
      },
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
  styles = {
    dashboard = {
      wo = {
        fillchars = 'eob: ',
      },
    },
    terminal_float = {
      position = 'float',
      border = 'rounded',
      height = 0.9,
      width = 0.9,
      bo = {
        filetype = 'snacks_terminal',
      },
      wo = {},
      stack = true,
      keys = {
        q = 'hide',
        gf = function(self)
          local f = vim.fn.findfile(vim.fn.expand('<cfile>'), '**')
          if f == '' then
            Snacks.notify.warn('No file under cursor')
          else
            self:hide()
            vim.schedule(function()
              vim.cmd('e ' .. f)
            end)
          end
        end,
        term_normal = {
          '<esc>',
          function(self)
            self.esc_timer = self.esc_timer or (vim.uv or vim.loop).new_timer()
            if self.esc_timer:is_active() then
              self.esc_timer:stop()
              vim.cmd('stopinsert')
            else
              self.esc_timer:start(200, 0, function() end)
              return '<esc>'
            end
          end,
          mode = 't',
          expr = true,
          desc = 'Double escape to normal mode',
        },
      },
    },
  },
  terminal = {
    win = { style = 'terminal' },
  },
  startup = { enabled = false },
}

-- Keymaps
vim.keymap.set('n', '<leader>e', function() Snacks.explorer() end, { desc = '[E]xplorer (snacks)' })
vim.keymap.set('n', '-', function() Snacks.explorer() end, { desc = 'Open explorer (snacks)' })
vim.keymap.set('n', '<leader>d', function() Snacks.dashboard() end, { desc = '[D]ashboard' })
vim.keymap.set('n', '<leader>gg', function() Snacks.lazygit() end, { desc = '[G]it [G]ui (lazygit)' })
vim.keymap.set('n', '<leader>gl', function() Snacks.lazygit.log() end, { desc = '[G]it [L]og (lazygit)' })
vim.keymap.set('n', '<leader>zz', function() Snacks.zen() end, { desc = '[Z]en mode (code)' })
vim.keymap.set('n', '<leader>zp', function()
  Snacks.zen.zen {
    win = {
      width = 80,
      wo = {
        number = false,
        relativenumber = false,
        wrap = true,
        linebreak = true,
        breakindent = true,
      },
    },
  }
end, { desc = 'Zen mode [p]rose' })

-- Justify paragraph with custom script (prompt for width)
vim.keymap.set('n', '<leader>j', function()
  local win_w = vim.api.nvim_win_get_width(0)
  local default_width = 75
  if win_w < 75 then default_width = win_w end
  vim.ui.input({ prompt = 'Justify width [' .. default_width .. ']: ', default = tostring(default_width) }, function(input)
    if not input or input == '' then return end
    local w = tonumber(input)
    if not w or w < 20 or w > 200 then
      vim.notify('Invalid width: ' .. input, 'error')
      return
    end
    local old_prg = vim.o.formatprg
    vim.o.formatprg = 'justify -w' .. w
    vim.cmd('normal! gqip')
    vim.o.formatprg = old_prg
  end)
end, { desc = '[J]ustify paragraph (prompt width)' })

vim.keymap.set('x', '<leader>j', function()
  local win_w = vim.api.nvim_win_get_width(0)
  local default_width = 75
  if win_w < 75 then default_width = win_w end
  vim.ui.input({ prompt = 'Justify width [' .. default_width .. ']: ', default = tostring(default_width) }, function(input)
    if not input or input == '' then return end
    local w = tonumber(input)
    if not w or w < 20 or w > 200 then
      vim.notify('Invalid width: ' .. input, 'error')
      return
    end
    vim.api.nvim_feedkeys(
      vim.api.nvim_replace_termcodes(":'<,'>!justify -w" .. w .. "<CR>", true, false, true),
      'n', false
    )
  end)
end, { desc = '[J]ustify selection (prompt width)' })

-- Terminal keymaps
vim.keymap.set('n', '<leader>tt', function() Snacks.terminal.toggle(nil, { win = { position = 'current' } }) end, { desc = '[T]erminal like :terminal (current window)' })
vim.keymap.set('n', '<leader>tf', function() Snacks.terminal.toggle(nil, { win = { style = 'terminal_float' } }) end, { desc = '[T]erminal [F]loat' })


-- Toggle keymaps
vim.keymap.set('n', '<leader>ud', function() Snacks.toggle.diagnostics() end, { desc = 'Toggle [D]iagnostics' })
vim.keymap.set('n', '<leader>ul', function() Snacks.toggle.line_number() end, { desc = 'Toggle [L]ine numbers' })
vim.keymap.set('n', '<leader>ui', function() Snacks.toggle.indent() end, { desc = 'Toggle [I]ndent guides' })
vim.keymap.set('n', '<leader>ut', function() Snacks.toggle.treesitter() end, { desc = 'Toggle [T]reesitter highlighting' })
vim.keymap.set('n', '<leader>uh', function() Snacks.toggle.inlay_hints() end, { desc = 'Toggle Inlay [H]ints' })
vim.keymap.set('n', '<leader>uw', function() Snacks.toggle.words() end, { desc = 'Toggle [W]ords highlighting' })

-- Dashboard header highlight — uses theme's Special or Statement color
vim.api.nvim_create_autocmd('ColorScheme', {
  group = vim.api.nvim_create_augroup('SnacksDashboardHeader', { clear = true }),
  callback = function()
    local ok, hl = pcall(vim.api.nvim_get_hl, 0, { name = 'Special', link = false })
    if ok and hl and hl.fg then
      vim.api.nvim_set_hl(0, 'SnacksDashboardHeader', { fg = hl.fg })
    else
      vim.api.nvim_set_hl(0, 'SnacksDashboardHeader', { fg = '#bdbdbd' })
    end
  end,
})
