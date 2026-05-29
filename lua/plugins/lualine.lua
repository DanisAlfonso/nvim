local gh = require('helpers').gh

vim.pack.add({
    gh('nvim-tree/nvim-web-devicons'),
    gh('nvim-lualine/lualine.nvim'),
})

-- Load the active theme's lualine config from lua/themes/
-- Change the active theme in lua/themes/init.lua
local active_theme = require("themes")
local lualine_theme = active_theme.lualine_theme or "auto"

require('lualine').setup {
    options = {
        theme = lualine_theme,
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
        disabled_filetypes = { 'snacks_dashboard', 'snacks_terminal', 'neo-tree' },
        always_divide_middle = true,
        globalstatus = true,
    },
    sections = {
        lualine_a = {
            { 'mode', icon = '󰘳', separator = { left = '', right = '' }, right_padding = 2 },
        },
        lualine_b = {
            { 'branch', icon = '', color = { fg = '#7aa2f7', gui = 'bold' } },
        },
        lualine_c = {
            { 'filename', path = 1, symbols = { modified = ' ●', readonly = ' ', unnamed = ' ' } },
        },
        lualine_x = {
            { 'diagnostics', sources = { 'nvim_diagnostic' }, symbols = { error = ' ', warn = ' ', info = ' ', hint = ' ' } },
            { 'filetype', icon_only = true },
            { 'datetime', style = '%H:%M', icon = '' },
        },
        lualine_y = {
            { 'progress', separator = { left = '', right = '' } },
            { 'location', separator = { left = '' } },
        },
        lualine_z = {},
    },
    extensions = { 'fugitive', 'quickfix', 'lazy' },
}
