local ACTIVE_THEME = "moonfly"

local theme = require("themes." .. ACTIVE_THEME)
theme.setup()
vim.cmd("colorscheme " .. theme.colorscheme)

return theme
