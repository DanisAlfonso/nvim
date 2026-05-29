-- Plugin declarations for color schemes.
-- Theme-specific setup & activation is in lua/themes/
-- To switch themes, edit lua/themes/init.lua

local gh = require('helpers').gh

vim.pack.add({
	{
		src = gh("rose-pine/neovim"),
		name = "rose-pine",
	},
	{
		src = gh("folke/tokyonight.nvim"),
		name = "tokyonight.nvim",
	},
	{
		src = gh("catppuccin/nvim"),
		name = "catppuccin",
	},
	{
		src = gh("vague-theme/vague.nvim"),
		name = "vague.nvim",
	},
	{
		src = gh("thesimonho/kanagawa-paper.nvim"),
		name = "kanagawa-paper.nvim",
	},
	{
		src = gh("cormacrelf/dark-notify"),
		name = "dark-notify",
	},
})

-- Apply the active theme (colorscheme setup + vim.cmd("colorscheme ..."))
require("themes")
