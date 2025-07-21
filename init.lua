vim.g.mapleader = " " -- Set leader key to spaces
vim.g.maplocalleader = " " -- Set local leader key to spaces
vim.g.have_nerd_font = true -- Set to true if you have nerd font installed
vim.opt.number = true -- Show line numbers
vim.opt.mouse = "a" -- Enable mouse support
vim.opt.showmode = false -- Disable showing mode in command line
vim.opt.breakindent = true -- Enable break indent
vim.opt.undofile = true -- Enable undo filename
vim.opt.ignorecase = true -- Ignore case when searching
vim.opt.smartcase = true -- Override ignorecase if search contains uppercase
vim.opt.signcolumn = "yes" -- Always show sign column
vim.opt.updatetime = 250 -- Faster completion
vim.opt.timeoutlen = 300 -- Time to wait for a mapped sequence to complete
vim.opt.splitright = true -- Split windows to the right
vim.opt.splitbelow = true -- Split windows below
vim.opt.list = true -- Show whitespace characters
vim.opt.listchars = {
	tab = "▸ ",
	extends = "⟩",
	precedes = "⟨",
	trail = "•",
} -- Customize whitespace characters
vim.opt.inccommand = "split" -- Show live substitutions
vim.opt.cursorline = true -- Show which line the cursor is on
vim.opt.confirm = true -- Confirm before overwriting files

vim.schedule(function()
	vim.opt.clipboard = "unnamedplus" -- Use system clipboard
end)

-- Keymaps
vim.keymap.set("n", "Esc", ":nohlsearch<CR>", { noremap = true, silent = true }) -- Clear search highlight

vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" }) -- Set keymap to open diagnostic quickfix list

-- TIP: Disable arrow keys in normal mode
vim.keymap.set("n", "<left>", '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set("n", "<right>", '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set("n", "<up>", '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set("n", "<down>", '<cmd>echo "Use j to move!!"<CR>')

vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })


-- Select all text
vim.keymap.set("n", "<leader>aa", "ggVG", { desc = "Select all", noremap = true, silent = true })

-- Delete all text
vim.keymap.set("n", "<leader>dd", "ggdG", { desc = "Delete all", noremap = true, silent = true })

-- Delete all without affecting clipboard
vim.keymap.set("n", "<leader>dD", 'gg"_dG', { desc = "Delete all (no clipboard)", noremap = true, silent = true })
vim.keymap.set("n", "<leader>da", "ggVGdi", { noremap = true, silent = true, desc = "Delete all contents" })
vim.keymap.set("n", "<leader>sa", "ggVG", { noremap = true, silent = true, desc = "Select all contents" })

vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		error("Error cloning lazy.nvim:\n" .. out)
	end
end
vim.opt.rtp:prepend(lazypath)

-- Load plugins
require("lazy").setup("plugins")
