local ACTIVE_THEME = "kanagawa-paper"

local theme = require("themes." .. ACTIVE_THEME)
theme.setup()
vim.cmd("colorscheme " .. theme.colorscheme)

return theme
