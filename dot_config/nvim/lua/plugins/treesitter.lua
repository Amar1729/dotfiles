-- ---- Tree-Sitter

return {
  -- use tree-sitter for language features
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function() require "configs.treesitter" end,
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
    opts = { useDefaultKeymaps = true },
  },

  -- TODO: this should be updated, as this version is archived
  -- pair highlighting
  {
    "https://git.sr.ht/~p00f/nvim-ts-rainbow",
    name = "nvim-ts-rainbow",
    url = "https://git.sr.ht/~p00f/nvim-ts-rainbow/",
  },

  -- display AST, write TS queries for buffer
  {
    "nvim-treesitter/playground",
    cmd = { "TSPlayGround", "TSPlayGroundToggle" },
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
