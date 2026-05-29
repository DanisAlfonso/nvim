-- autopairs

local gh = require('helpers').gh

vim.pack.add { gh('windwp/nvim-autopairs') }
require('nvim-autopairs').setup {}
