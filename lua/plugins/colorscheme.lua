vim.pack.add({
	{
		src = "https://github.com/rose-pine/neovim",
		name = "rose-pine",
	},
	{
		src = "https://github.com/folke/tokyonight.nvim",
		name = "tokyonight.nvim",
	},
})
require("tokyonight").setup({
    style = "moon",
    transparent = true,
    styles = {
        sidebars = "transparent",
        floats = "transparent",
    },
    on_highlights = function(hl, c)
        hl.StatusLine = { fg = c.fg_sidebar, bg = "NONE" }
        hl.StatusLineNC = { fg = c.fg_gutter, bg = "NONE" }
    end,
})
vim.cmd("colorscheme tokyonight-moon")
