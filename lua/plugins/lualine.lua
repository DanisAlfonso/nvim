vim.pack.add({
    'https://github.com/nvim-tree/nvim-web-devicons',
    'https://github.com/nvim-lualine/lualine.nvim',
})

-- Beautiful lualine for TokyoNight Night (transparent)
-- Cargamos el theme de TokyoNight y hacemos transparente la sección 'c'
-- (la del medio, donde va el filename)
local theme = require('lualine.themes.tokyonight')
for _, mode in pairs(theme) do
    if mode.c then
        mode.c.bg = 'NONE'
    end
end

require('lualine').setup {
    options = {
        theme = theme,
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
