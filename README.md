# 💤 Modular Neovim Configuration

Welcome to your modern, modular Neovim configuration! This setup is designed for power users and beginners alike, with a focus on:
- **Modularity**: Each plugin and feature is configured in its own file for easy customization.
- **Reproducibility**: Uses [lazy.nvim](https://github.com/folke/lazy.nvim) for plugin management and a lockfile for consistent plugin versions.
- **Aesthetics**: Beautiful UI with TokyoNight theme, Bubbles lualine, and icons.
- **Productivity**: Includes fuzzy finding, git integration, file explorer, distraction-free mode, and more.

---

## ✨ Features
- **Plugin management**: [lazy.nvim](https://github.com/folke/lazy.nvim)
- **Theme**: [tokyonight.nvim](https://github.com/folke/tokyonight.nvim)
- **Statusline**: [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim) (Bubbles theme)
- **Fuzzy finder**: [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)
- **File explorer**: [oil.nvim](https://github.com/stevearc/oil.nvim)
- **Git integration**: [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim)
- **Keybinding helper**: [which-key.nvim](https://github.com/folke/which-key.nvim)
- **Distraction-free writing**: [zen-mode.nvim](https://github.com/folke/zen-mode.nvim)
- **Icons**: [nvim-web-devicons](https://github.com/nvim-tree/nvim-web-devicons)

---

## 🚀 Quick Start

### 1. **Clone this repo**
```sh
git clone https://github.com/DanisAlfonso/nvim.git ~/.config/nvim
```

### 2. **Open Neovim**
Neovim will automatically install [lazy.nvim](https://github.com/folke/lazy.nvim) and all plugins on first launch.

```sh
nvim
```

### 3. **(Optional) Install dependencies**
- [Nerd Font](https://www.nerdfonts.com/) for best icon support
- [ripgrep](https://github.com/BurntSushi/ripgrep) for fast searching (used by Telescope)
- [fd](https://github.com/sharkdp/fd) for better file finding

---

## 🗂️ Directory Structure

```
.config/nvim/
├── init.lua                # Main Neovim config entrypoint
├── lua/
│   └── plugins/            # All plugin configs live here
│       ├── lazy.lua
│       ├── gitsigns.lua
│       ├── which-key.lua
│       ├── telescope.lua
│       ├── oil.lua
│       ├── zen-mode.lua
│       ├── lualine.lua
│       └── themes/
│           ├── init.lua
│           └── tokyonight.lua
├── .gitignore
├── README.md
└── lazy-lock.json          # (Optional) Plugin lockfile for reproducibility
```

---

## ⚙️ Customization

- **Add/Remove plugins**: Add or remove files in `lua/plugins/`.
- **Change theme**: Edit `lua/plugins/themes/init.lua` and add your favorite theme config.
- **Keymaps**: Most keymaps are set in plugin config files or in `init.lua`.
- **Statusline**: Customize `lua/plugins/lualine.lua` for your preferred look.

---

## 🛠️ Notable Keymaps

| Keymap         | Action                        |
| -------------- | ---------------------------- |
| `<leader>e`    | Open Oil file explorer       |
| `<leader>sf`   | Telescope find files         |
| `<leader>sg`   | Telescope live grep          |
| `<leader>sh`   | Telescope help tags          |
| `<leader>ss`   | Telescope select picker      |
| `<leader>q`    | Open diagnostic quickfix     |
| `<leader>?`    | Show buffer local keymaps    |
| `<leader>th`   | Toggle horizontal terminal   |
| `<leader>tv`   | Toggle vertical terminal     |
| `<leader>tf`   | Toggle floating terminal     |
| `<leader>h`    | Git hunk commands            |

---

## 📝 Tips
- **Update plugins**: Run `:Lazy update` in Neovim.
- **Check plugin status**: Run `:Lazy`.
- **Add your own plugins**: Drop a new `.lua` file in `lua/plugins/`.
- **Switch themes**: Add your theme config to `lua/plugins/themes/` and require it in `themes/init.lua`.
