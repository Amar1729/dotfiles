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
      -- bidirectional leap from normal mode
      vim.keymap.set('n',        's', '<Plug>(leap)')
      vim.keymap.set('n',        'S', '<Plug>(leap-from-window)')
      vim.keymap.set({'x', 'o'}, 's', '<Plug>(leap-forward)')
      -- interferes with vim-surround
      -- vim.keymap.set({'x', 'o'}, 'S', '<Plug>(leap-backward)')

      -- enter always repeats last search forward, backspace backward.
      require("leap.user").set_repeat_keys("<enter>", "<backspace>")

      -- spoOky
      vim.keymap.set({ "n", "x", "o" }, "gs", function ()
        require("leap.remote").action()
      end)

      -- auto-paste after spoOky yank
      vim.api.nvim_create_augroup('LeapRemote', {})
      vim.api.nvim_create_autocmd('User', {
        pattern = 'RemoteOperationDone',
        group = 'LeapRemote',
        callback = function (event)
          -- Do not paste if some special register was in use.
          if vim.v.operator == 'y' and event.data.register == '"' then
            vim.cmd('normal! p')
          end
        end,
      })

      vim.keymap.set({ "n", "x", "o" }, "ga", function ()
        require("leap.treesitter").select()
      end, { desc = "Leap over TS Nodes" })

      vim.keymap.set({ "n", "x", "o" }, "gA",
        'V<cmd>lua require("leap.treesitter").select()<cr>',
        { desc = "Leap over TS Nodes (linewise)" }
      )
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
