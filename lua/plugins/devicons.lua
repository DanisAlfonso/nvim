-- nvim-web-devicons: icons for file types (only if Nerd Font is available)
local gh = require('helpers').gh
if vim.g.have_nerd_font then vim.pack.add { gh('nvim-tree/nvim-web-devicons') } end
