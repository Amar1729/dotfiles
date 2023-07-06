-- ---- Text Manipulation
-- plugins roughly ordered in terms of how "important" they are to every-day use

return {
  -- for surrounding phrases with characters
  -- "tpope/vim-surround",
  {
    "kylechui/nvim-surround",
    config = true,
  },

  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {},
  },

  -- undotree visualization/movement
  "mbbill/undotree",

  -- TS structural search and replace
  "cshuaimin/ssr.nvim",

  -- TS-aware commenting
  {
    "numToStr/Comment.nvim",
    config = true,
  },

  -- TS-aware split/join
  {
    "Wansmer/treesj",
    config = function() require "configs.treesj" end,
  },

  -- c-a/c-x for time/dates
  "tpope/vim-speeddating",

  -- c-a/c-x for common strings (true/false, yes/no, colors)
  {
    "nat-418/boole.nvim",
    opts = {
      mappings = {
        increment = "<C-a>",
        decrement = "<C-x>",
      },
      additions = {
        -- full month names, full day names, day abbrevs handled by boole
        { "jan", "feb", "mar", "apr", "may", "jun", "jul", "aug", "sep", "oct", "nov", "dec" },
        { "Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec" },
      },
    },
  },

  -- handy docstring generator
  {
    "danymat/neogen",
    -- dependencies = "nvim-treesitter/nvim-treesitter",
    config = function ()
      require("neogen").setup({
        -- can't quite get the snippets to expand properly right now...
        -- snippet_engine = "luasnip",
      })
    end,
  },
}
