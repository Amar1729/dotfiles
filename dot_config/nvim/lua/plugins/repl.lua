-- REPL / code-runner plugins.

return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    opts = {
      open_mapping = [[<c-\>]]
      -- TODO: maybe add bindings for sending lines over?
      -- e.g. python to ipython, or bash lines in markdown
    },
  },

  {
    "rest-nvim/rest.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "rcarriga/nvim-notify",
    },
    ft = { "http" },
    opts = true,
  },

  -- silent conversion of notebooks to flat text
  {
    "goerz/jupytext.vim",
    init = function ()
      vim.g.jupytext_fmt = "md"
    end,
  },

  -- LSP / code running / file rendering in markdown
  {
    -- "quarto-dev/quarto-nvim",
    "benlubas/quarto-nvim",
    dependencies = {
      -- LSP for code embedded in other file formats (e.g. python in markdown)
      -- (should this have its own config???)
      "jmbuhr/otter.nvim",

      -- make sure LSP niceties are loaded (is this a dep cycle?)
      "hrsh7th/nvim-cmp",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
      -- hydra
    },
    ft = { "quarto", "markdown" },
    config = function ()
      local quarto = require("quarto")
      quarto.setup({
        lspFeatures = {
          languages = { "python", "rust" },
          chunks = "all",
          diagnostics = {
            enabled = true,
            triggers = { "BufWritePost" },
          },
          completion = {
            enabled = true,
          },
        },
        keymap = {
          hover = "K",
          definition = "gd",
          rename = "<space>r",
          references = "gr",
          format = "<space>f",
        },
        codeRunner = {
          enabled = true,
          ft_runners = {
            -- not installed yet
            bash = "slime",
          },
          default_method = "molten",
        },
      })

      -- TODO
      -- vim.api.nvim_create_autocmd("FileType", {
      --   pattern = "markdown",
      --   callback = function ()
      --     print("changed type")
      --   end,
      -- })

      -- todo: copy over a bunch of keymaps
      vim.keymap.set("n", "<leader>qp", quarto.quartoPreview, { desc = "Preview the Quarto document", silent = true, noremap = true })
      vim.keymap.set("n", "<leader>cc", "i```{}\r```<up><right>", { desc = "Create new code cell", silent = true })
    end,
  },

  -- help with jupyter notebooks
  {
    "benlubas/molten-nvim",
    build = ":UpdateRemotePlugins",
    keys = {
      -- my own keybinds for initialization
      { "<leader>mi", },
      { "<leader>ir", },
    },
    dependencies = {
      -- depends on jupytext converting .ipynb files on open.
      "goerz/jupytext.vim",

      -- depends on quarto to provide lsp/code running in markdown (output of jupytext)
      -- (make sure to use same quarto repo as above)
      "benlubas/quarto-nvim",

      -- lua imagemagick rock kind of broken on arm mac rn. disabling.
      -- {
      --   "3rd/image.nvim",
      --   -- additional opts that are required within molten
      --   opts = {
      --     max_width = 100,
      --     max_height = 12,
      --     max_height_window_percentage = math.huge,
      --     max_width_window_percentage = math.huge,
      --     window_overlap_clear_enabled = true,
      --     window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
      --   },
      -- },
    },
    init = function ()
      -- load the install imagemagick luarock (for image.nvim)
      -- doesn't seem to work anymore.
      -- package.path = package.path .. ";" .. vim.fn.expand("$HOME") .. "/.luarocks/share/lua/5.1/?/init.lua;"
      -- package.path = package.path .. ";" .. vim.fn.expand("$HOME") .. "/.luarocks/share/lua/5.1/?.lua;"

      vim.g.molten_auto_open_output = true
      -- vim.g.molten_image_provider = "image.nvim"
      vim.g.molten_output_crop_border = true

      vim.g.molten_output_win_max_height = 40
      -- vim.g.molten_virt_text_output = true
      vim.g.molten_use_border_highlights = true
      -- vim.g.molten_virt_lines_off_by_1 = true
      vim.g.molten_wrap_output = true

      vim.keymap.set("n", "<leader>mi", ":MoltenInit<CR>", { desc = "Initialize Molten", silent = true })
      vim.keymap.set("n", "<leader>ir", function ()
        local venv = os.getenv("VIRTUAL_ENV")
        if venv ~= nil then
          venv = string.match(venv, "/.+/(.+)")
          vim.cmd(("MoltenInit %s"):format(venv))
        else
          vim.cmd("MoltenInit python3")
        end
      end, { desc = "Initialize Molten for python3", silent = true, noremap = true })

      vim.api.nvim_create_autocmd("User", {
        pattern = "MoltenInitPost",
        callback = function ()
          -- change some vim settings
          vim.opt.conceallevel = 0
          vim.cmd [[ TSContextDisable ]]

          -- ... always just activate quarto?
          require("quarto").activate()
          vim.notify("Quarto activated.") -- maybe put this in a pcall w/ .activate() to actually check if we're good

          local r = require("quarto.runner")
          vim.keymap.set("n", "<leader>rc", r.run_cell, { desc = "run cell", silent = true })
          vim.keymap.set("n", "<leader>rA", r.run_all, { desc = "run all cells", silent = true })

          vim.keymap.set("n", "<Esc>", ":noautocmd MoltenHideOutput<CR>", { desc = "Close output window", silent = true })

          vim.keymap.set("n", "]x", ":noautocmd MoltenNext<CR>", { desc = "Next Molten Cell", silent = true })
          vim.keymap.set("n", "[x", ":noautocmd MoltenPrev<CR>", { desc = "Previous Molten Cell", silent = true })
        end,
      })
    end,
  },
}
