-- macOS dark/light mode auto-switcher for Neovim
-- Requires: brew install cormacrelf/tap/dark-notify
--
-- Uses the dark-notify Lua plugin (cormacrelf/dark-notify) as a child process
-- to detect macOS appearance changes via NSDistributedNotificationCenter
-- (event-driven, no polling).
--
-- On each change it:
--   1. Sets vim.o.background = "dark" | "light"
--   2. Clears the theme module cache so lualine picks up the new theme colors
--
-- The colorscheme (kanagawa-paper) auto-detects based on vim.o.background,
-- and lualine has a built-in autocmd on OptionSet background that re-applies
-- the theme, so no manual lualine refresh is needed.

-- Initialise dark-notify after VimEnter so vim.pack has installed the plugin
vim.api.nvim_create_autocmd("VimEnter", {
  group = vim.api.nvim_create_augroup("dark-notify-init", { clear = true }),
  desc = "Start dark-notify for automatic dark/light mode switching",
  callback = function()
    local ok, dn = pcall(require, "dark_notify")
    if not ok then
      vim.notify(
        "dark-notify plugin not available. Run :lua vim.pack.update() to install.",
        vim.log.levels.WARN
      )
      return
    end

    dn.run({
      schemes = {
        dark = { background = "dark" },
        light = { background = "light" },
      },
      onchange = function(mode)
        -- Clear theme cache so lualine's built-in OptionSet background
        -- autocmd picks up fresh theme colors on next setup() call
        package.loaded["themes"] = nil
        vim.notify("OS theme switched to " .. mode, vim.log.levels.INFO)
      end,
    })
  end,
  once = true,
})
