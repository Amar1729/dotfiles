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
    "altermo/ultimate-autopair.nvim",
    event = { "InsertEnter", "CmdlineEnter" },
    branch = "v0.6",
    enabled = true,
    opts = {
      { "<", ">", ft = { "rust" } },
      { "|", "|", ft = { "rust" } },
    },
  },

  {
    -- this plugin can't seem to do rust || very well.
    -- also, it doesn't auto-do mirrored spaces between pairs.
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    enabled = false,
    config = function ()
      local autopairs = require("nvim-autopairs")
      local Rule = require("nvim-autopairs.rule")
      local cond = require("nvim-autopairs.conds")

      autopairs.setup({})

      autopairs.add_rules {
        -- autopair<>
        -- all languages? or just xml/langs w/ <> generics?
        Rule("<", ">")
          :with_pair(cond.before_regex("%a+"))
          :with_move(function (opts)
            return opts.char == ">"
          end),
        -- autopair||  <-- this one might be buggy? oh well
        Rule("|", "|", "rust")
          -- match letters or open parens
          :with_pair(cond.before_regex("[%a(]+"))
          :with_move(function (opts)
            return opts.char == "|"
          end),
      }
    end,
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
      allow_caps_additions = {
        -- full month names, full day names, day abbrevs handled by boole
        { "jan", "feb", "mar", "apr", "may", "jun", "jul", "aug", "sep", "oct", "nov", "dec" },

        -- English numbers
        { "one", "two", "three", "four", "five", "six", "seven", "eight", "nine", "zero" },
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

  -- auto-convert strings to/from f-strings/template strings
  {
    "chrisgrieser/nvim-puppeteer",
    dependencies = "nvim-treesitter/nvim-treesitter",
    lazy = false,
    ft = { "python", "javascript", "typescript" },
  },

  -- highlight things that change between undos
  {
    "tzachar/highlight-undo.nvim",
    opts = {
      duration = 800,
      undo = {
        hlgroup = "Normal",
      },
      redo = {
        hlgroup = "Normal",
      },
    },
  },
}
