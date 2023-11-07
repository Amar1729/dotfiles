-- ---- Movement

return {
  -- many consistent bindings for movement and simple manipulations
  "tpope/vim-unimpaired",

  -- tmux/vim interop
  "christoomey/vim-tmux-navigator",

  -- move through CamelCase, snake_case words better
  {
    "chrisgrieser/nvim-spider",
    keys = {
      {
        "w",
        "<cmd>lua require('spider').motion('w')<CR>",
        mode = { "n", "o", "x" },
      },
      {
        "e",
        "<cmd>lua require('spider').motion('e')<CR>",
        mode = { "n", "o", "x" },
      },
      {
        "b",
        "<cmd>lua require('spider').motion('b')<CR>",
        mode = { "n", "o", "x" },
      },
      {
        "ge",
        "<cmd>lua require('spider').motion('ge')<CR>",
        mode = { "n", "o", "x" },
      },
    },
  },

  -- movement over treesitter nodes.
  -- very experimental, but seems promising.
  {
    "ziontee113/syntax-tree-surfer",
    config = true,
  },

  -- digraph-based search through visible buffer
  {
    "ggandor/leap.nvim",
    config = function()
      require("leap").add_default_mappings()

      require("leap").add_repeat_mappings(";", "\\", {
        relative_directions = false,
      })
    end,
  },

  -- multi-line f/t
  {
    "ggandor/flit.nvim",
    opts = {
      labeled_modes = "n",
      special_keys = {
        repeat_search = { "<Enter>" },
      },
      opts = {
        special_keys = {
          repeat_search = { "<Enter>" },
        }
      },
    },
  },

  -- actions from a distance, using leap
  {
    "ggandor/leap-spooky.nvim",
    opts = {
      prefix = true,
      paste_on_remote_yank = true,
    },
  },

  -- cool searching
  {
    "kevinhwang91/nvim-hlslens",
    keys = {
      "n",
      "N",
      "*",
      "#",
      "/",
      "?",
    },
    opts = {
      calm_down = false,
      nearest_only = true,
      virt_priority = 10,
    },
  },

  -- easier movement through locations
  {
    "cbochs/portal.nvim",
    config = function () require("configs.portal") end,
    dependencies = {
      "cbochs/grapple.nvim",
      "ThePrimeagen/harpoon",
    },
  },
}
