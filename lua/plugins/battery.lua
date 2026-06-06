local gh = require('helpers').gh

vim.pack.add {
    gh('justinhj/battery.nvim'),
}

-- Initialise battery after VimEnter so vim.pack has installed the plugin
vim.api.nvim_create_autocmd("VimEnter", {
    group = vim.api.nvim_create_augroup("battery-init", { clear = true }),
    desc = "Start battery.nvim for battery percentage in statusline",
    callback = function()
        local ok, battery = pcall(require, "battery")
        if not ok then
            vim.notify(
                "battery.nvim not available. Run :lua vim.pack.update() to install.",
                vim.log.levels.WARN
            )
            return
        end

        battery.setup({
            update_rate_seconds = 60,
            show_status_when_no_battery = false,
            show_plugged_icon = true,
            show_unplugged_icon = true,
            show_percent = true,
            vertical_icons = true,
            multiple_battery_selection = 1,
        })
    end,
    once = true,
})
