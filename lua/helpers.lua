-- Because most plugins are hosted on GitHub, you can use the helper
-- function to have less repetition in plugin configurations.

local M = {}

---Return a full GitHub URL for the given repo path.
---@param repo string e.g. 'folke/which-key.nvim'
---@return string
function M.gh(repo)
  return 'https://github.com/' .. repo
end

return M
