-- Automatically detects indentation settings
local gh = require('helpers').gh
vim.pack.add { gh('NMAC427/guess-indent.nvim') }
require('guess-indent').setup {}
