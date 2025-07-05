return {
	{
		"nvim-neorg/neorg",
		build = ":Neorg sync-parsers",
		version = "*", -- Use the latest stable version
		dependencies = { 
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
			"nvim-treesitter/nvim-treesitter-textobjects",
			"nvim-cmp",
			"hrsh7th/nvim-cmp", -- Optional: for completion
		},
		config = function()
			-- Ensure treesitter is properly set up
			local ok, _ = pcall(require, "nvim-treesitter")
			if not ok then
				vim.notify("nvim-treesitter not found, Neorg may not work properly", vim.log.levels.WARN)
				return
			end

			require("neorg").setup {
				load = {
					["core.defaults"] = {}, -- Loads default behaviour
					["core.concealer"] = {}, -- Adds pretty icons to your documents
					["core.dirman"] = { -- Manages Neorg workspaces
						config = {
							workspaces = {
								notes = "~/notes",
								work = "~/notes/work",
								personal = "~/notes/personal",
							},
							default_workspace = "notes",
						},
					},
					["core.completion"] = {
						config = {
							engine = "nvim-cmp",
						},
					},
					["core.summary"] = {}, -- Provides a summary of the current document
					["core.export"] = {}, -- Allows exporting to different formats
					["core.presenter"] = {
						config = {
							zen_mode = "zen-mode",
						},
					},
				},
			}

			-- Set up some keymaps
			local neorg_callbacks = require("neorg.core.callbacks")

			neorg_callbacks.on_event("core.keybinds.events.enable_keybinds", function(_, keybinds)
				-- Map all the below keybinds only when the "norg" mode is active
				keybinds.map_event_to_mode("norg", {
					n = { -- Bind keys in normal mode
						{ "<leader>nn", "core.dirman.new.note" },
						{ "<leader>nf", "core.dirman.find.note" },
						{ "<leader>ni", "core.dirman.open.index" },
					},
				}, {
					silent = true,
					noremap = true,
				})
			end)
		end,
	}
} 