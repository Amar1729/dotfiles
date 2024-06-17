-- ---- Language-Server Protocol (LSP) plugins + Completions (nvim-cmp)
-- Some other language-specific things, such as snippets/skeletons
-- Note: LSP functionality is built-in to neovim. these plugins simply enhance its ux
-- ---- ---- ---- ---- ---- ----

return {
  -- standard configs for popular LSP servers
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      {
        -- development settings for lua files under nvim root
        "folke/lazydev.nvim",
        ft = "lua",
        dependencies = {
          -- this is only for some vim submodules
          { "Bilal2453/luvit-meta", lazy = true },
          { "justinsgithub/wezterm-types", lazy = true },
        },
        opts = {
          -- make sure to remove the .luarc.json, if you've created one from an older luals helper.
          library = {
            { path = "luvit-meta/library", words = { "vim%.uv" } },
            { path = "wezterm-types", mods = { "wezterm" } },
          },
        },
      },
      {
        -- completion candidates for nvim-cmp
        "hrsh7th/cmp-nvim-lsp",
      },
      -- provide virtual text inline type hints
      {
        "lvimuser/lsp-inlayhints.nvim",
        -- config = true,
        opts = {
          inlay_hints = {
            type_hints = {
              prefix = "<= ",
            },
            highlight = "Comment",
          },
        },
      },
    },
    config = function ()
      require("configs.lsp.view")
      require("configs.lsp.servers").setup()
    end,
  },

  -- use vscode snips from friendly-snippets
  {
    "L3MON4D3/LuaSnip",
    event = { "InsertEnter", "CmdlineEnter" },
    version = "v1.*",
    dependencies = {
      "rafamadriz/friendly-snippets",
    },
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()

      -- custom snips
      require("configs.snippets")
    end,
  },

  {
    "hrsh7th/nvim-cmp",
    event = { "InsertEnter", "CmdlineEnter" },
    dependencies = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "saadparwaiz1/cmp_luasnip",
      "kristijanhusak/vim-dadbod-completion",
    },
    config = function() require("configs.cmp") end,
  },

  -- skeleton files for common fts
  {
    "cvigilv/esqueleto.nvim",
    -- require dressing (nicer wrapper for vim.ui.select)
    -- but only when creating a new file
    dependencies = { "dressing.nvim" },
    event = { "BufNewFile" },
    opts = {
      directories = { "~/.config/nvim/templates/" },
      patterns = {
        "LICENSE",
        "python",
        "sh",
      },
    },
  },

  -- auto-popup signature_help while in insert mode inside a method's param list
  {
    "ray-x/lsp_signature.nvim",
    opts = { bind = true },
  },

  -- LSP-based previews, jumping
  {
    "DNLHC/glance.nvim",
    opts = {
      preview_win_opts = {
        relativenumber = false,
      },
      border = {
        enable = true,
      }
    },
  },
}
