-- Plugin declarations for color schemes.
-- Theme-specific setup & activation is in lua/themes/
-- To switch themes, edit lua/themes/init.lua

vim.pack.add({
	{
		src = "https://github.com/rose-pine/neovim",
		name = "rose-pine",
	},
	{
		src = "https://github.com/folke/tokyonight.nvim",
		name = "tokyonight.nvim",
	},
	{
		src = "https://github.com/catppuccin/nvim",
		name = "catppuccin",
	},
	{
		src = "https://github.com/vague-theme/vague.nvim",
		name = "vague.nvim",
	},
	{
		src = "https://github.com/thesimonho/kanagawa-paper.nvim",
		name = "kanagawa-paper.nvim",
	},
	{
		src = "https://github.com/cormacrelf/dark-notify",
		name = "dark-notify",
	},
})

-- Apply the active theme (colorscheme setup + vim.cmd("colorscheme ..."))
require("themes")
