-- ---- Tree-Sitter

return {
  -- use tree-sitter for language features
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function() require "configs.treesitter" end,
    dependencies = {
      {
        "IndianBoy42/tree-sitter-just",
        config = true,
      },
    },
  },

  "nvim-treesitter/nvim-treesitter-context",
  "nvim-treesitter/nvim-treesitter-textobjects",

  -- more textobjects
  {
    "echasnovski/mini.ai",
    main = "mini.ai",
    config = true,
  },

  -- more textobjects
  {
    "chrisgrieser/nvim-various-textobjs",
    -- not a dependency for functionality: used for opening a gx link in browser but i use this only for the quick-opening of links for gx
    dependencies = {
      {
        "axieax/urlview.nvim",
        opts = { default_action = "system" },
      },
    },
    opts = {
      useDefaultKeymaps = true,
      disabledKeymaps = { "r" },
    },
  },

  -- pair highlighting
  {
    "https://gitlab.com/HiPhish/rainbow-delimiters.nvim",
    name = "rainbow-delimiters.nvim",
    url = "https://gitlab.com/HiPhish/rainbow-delimiters.nvim",
    -- TODO: doesn't update <> or || pairs (e.g. for rust)
  },

  -- conceal (horizontally fold) keywords
  {
    "Jxstxs/conceal.nvim",
    build = ":lua require'conceal'.generate_conceals()",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    -- default: lua and python are enabled (and a few c keywords)
    opts = {},
  },
}
