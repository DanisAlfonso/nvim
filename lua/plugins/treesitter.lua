return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		event = { "BufReadPost", "BufNewFile" },
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
		},
		config = function()
			-- Import nvim-treesitter plugin
			local treesitter = require("nvim-treesitter.configs")

			-- Set compiler preferences for macOS
			if vim.fn.has("macunix") == 1 then
				require("nvim-treesitter.install").compilers = { "clang", "gcc" }
				-- Set a custom parser install directory to avoid runtimepath issues
				require("nvim-treesitter.install").prefer_git = true
			end

			-- Configure nvim-treesitter
			treesitter.setup({
				-- Enable syntax highlighting
				highlight = {
					enable = true,
					additional_vim_regex_highlighting = false,
				},
				-- Enable indentation
				indent = { enable = true },
				-- Enable autotagging (w/ nvim-ts-autotag plugin)
				autotag = { enable = true },
				-- Install parsers synchronously (only applied to `ensure_installed`)
				sync_install = false,
				-- Automatically install missing parsers when entering buffer
				auto_install = true,
				-- Ensure these language parsers are installed
				ensure_installed = {
					"lua",
					"vim",
					"vimdoc",
					"query",
					"javascript",
					"typescript",
					"tsx",
					"javascript",
					"jsdoc",
					"regex",
					"python",
					"c",
					"cpp",
					"rust",
					"go",
					"html",
					"css",
					"scss",
					"json",
					"jsonc",
					"yaml",
					"markdown",
					"markdown_inline",
					"bash",
					"norg",
				},
				incremental_selection = {
					enable = true,
					keymaps = {
						init_selection = "<C-space>",
						node_incremental = "<C-space>",
						scope_incremental = false,
						node_decremental = "<bs>",
					},
				},
				textobjects = {
					select = {
						enable = true,
						lookahead = true,
						keymaps = {
							-- You can use the capture groups defined in textobjects.scm
							["af"] = "@function.outer",
							["if"] = "@function.inner",
							["ac"] = "@class.outer",
							["ic"] = "@class.inner",
						},
					},
					move = {
						enable = true,
						set_jumps = true,
						goto_next_start = {
							["]f"] = "@function.outer",
							["]c"] = "@class.outer",
						},
						goto_next_end = {
							["]F"] = "@function.outer",
							["]C"] = "@class.outer",
						},
						goto_previous_start = {
							["[f"] = "@function.outer",
							["[c"] = "@class.outer",
						},
						goto_previous_end = {
							["[F"] = "@function.outer",
							["[C"] = "@class.outer",
						},
					},
				},
			})
		end,
	},
} 