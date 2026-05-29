-- Highlight TODO, FIXME, NOTE, etc in comments
local gh = require('helpers').gh
vim.pack.add { gh('folke/todo-comments.nvim') }
require('todo-comments').setup { signs = false }
