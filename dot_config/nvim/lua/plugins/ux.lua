-- ---- UX changes and add-ons

return {
  -- repeat motions from plugins and elsewhere
  "tpope/vim-repeat",

  -- telescope - arbitrary fuzzy-searching over lists (e.g. buffers or files in workspace)
  {
    "nvim-telescope/telescope.nvim",
    version = "0.1.x",
    cmd = "Telescope",
    dependencies = {
      "nvim-lua/plenary.nvim",

      -- search luasnip snippets from inside telescope
      {
        "benfowler/telescope-luasnip.nvim",
        config = function ()
          require("telescope").load_extension("luasnip")
        end,
      },

      -- much better alternative to fuzzy-picker
      -- essentially a wrapper over ripgrep, that allows for simple fuzzy searching and file extension filtering.
      {
        "fdschmidt93/telescope-egrepify.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
      },

      -- slightly faster compiled fzf
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        -- README says 'make' but it didn't seem to work
        -- build = "make",
        build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
        config = function ()
          require("telescope").load_extension("fzf")
        end
      },
    },
    config = function() require "configs.telescope" end,
  },

  -- git signs in gutter, management of hunks ;) and simple diff views
  {
    "lewis6991/gitsigns.nvim",
    config = function() require "configs.gitsigns" end,
  },

  -- better viewer for git history, git diffs
  {
    "sindrets/diffview.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = { use_icons = false },
  },

  -- use git from inside vim (e.g. `:Git commit`)
  "tpope/vim-fugitive",
}
