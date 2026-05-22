-- render-markdown.nvim: renders headings, code blocks, tables, etc. inline
-- https://github.com/MeanderingProgrammer/render-markdown.nvim
vim.pack.add {
  'https://github.com/MeanderingProgrammer/render-markdown.nvim',
}

require('render-markdown').setup {
  -- Heading icons + sign column, but NO background fill so terminal transparency shows through
  -- heading = {
  --   icons = { '󰲡 ', '󰲣 ', '󰲥 ', '󰲧 ', '󰲩 ', '󰲫 ' },
  --   position = 'overlay',
  --   width = 'block',
  --   sign = true,
  --   backgrounds = {},   -- empty = transparent, no colored block behind headings
  -- },

  -- Code blocks: no background fill, just a thin border + language icon
  code = {
    width = 'block',
    right_pad = 1,
    border = 'thin',
    disable_background = true,  -- transparent code block interior
  },

  -- Renders pipe tables with borders
  pipe_table = {
    preset = 'round',
    cell = 'padded',
    border_enabled = true,
  },

  -- Block quotes with colored left bar
  quote = {
    icon = '▋',
    repeat_linebreak = false,
  },

  -- GitHub-style callouts (NOTE, TIP, WARNING, CAUTION, IMPORTANT)
  callout = {
    note = { raw = '[!NOTE]', rendered = '󰋽 Note', highlight = 'RenderMarkdownInfo' },
    tip = { raw = '[!TIP]', rendered = '󰌶 Tip', highlight = 'RenderMarkdownSuccess' },
    important = { raw = '[!IMPORTANT]', rendered = '󰅾 Important', highlight = 'RenderMarkdownHint' },
    warning = { raw = '[!WARNING]', rendered = '󰀪 Warning', highlight = 'RenderMarkdownWarn' },
    caution = { raw = '[!CAUTION]', rendered = '󰳦 Caution', highlight = 'RenderMarkdownError' },
  },

  -- Checkboxes
  checkbox = {
    unchecked = { icon = '󰄱 ', highlight = 'RenderMarkdownUnchecked' },
    checked = { icon = '󰱒 ', highlight = 'RenderMarkdownChecked' },
  },

  -- Bullet list icons
  bullet = {
    icons = { '●', '○', '◆', '◇' },
    left_pad = 0,
    right_pad = 0,
  },

  -- LaTeX rendering (requires utftex or latex2text on PATH)
  latex = {
    enabled = true,
    converter = { 'utftex', 'latex2text' },
    position = 'center',
  },

  -- Anti-conceal: show raw text on cursor line, keep decorations elsewhere
  anti_conceal = {
    enabled = true,
    above = 1,
    below = 1,
    ignore = {
      code_background = true,
      code_border = true,
      indent = true,
      sign = true,
      virtual_lines = true,
    },
  },

  -- Padding uses Normal highlight which has no background in a transparent terminal
  padding = { highlight = 'Normal' },

  -- Don't render gitcommit diffs as markdown (too noisy)
  injections = {
    gitcommit = { enabled = false },
  },
}
