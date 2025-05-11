return {
  -- Load lazy.nvim first
  require("plugins.lazy"),

  -- Load other plugins
  require("plugins.gitsigns"),
  require("plugins.which-key"),

  -- Icons for which-key
  {
    "nvim-tree/nvim-web-devicons",
    lazy = true,
  },
} 