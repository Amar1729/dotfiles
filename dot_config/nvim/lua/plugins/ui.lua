-- ---- Theming and UI changes

return {
  "dylanaraps/wal.vim",

  -- don't use either of these anymore, but they're nice
  -- {"morhetz/gruvbox"}
  -- {"cpea2506/one_monokai.nvim"}
  -- {"rose-pine/neovim"}

  -- statusline
  {
    "nvim-lualine/lualine.nvim",
    config = function() require("configs.lualine") end,
  },

  -- use oil instead for file exploration?
  {
    "stevearc/oil.nvim",
    opts = {
      keymaps = {
        ["yp"] = {
          desc = "Copy filepath to system clipboard",
          callback = function ()
            require("oil.actions").copy_entry_path.callback()
            -- setreg not required i think(?) because i use autocmds for clipboard syncing.
            -- vim.fn.setreg("+", vim.fn.getreg(vim.v.register))
          end,
        },
      },
      default_file_explorer = true,
      columns = {
        "icon",
        "size",
      }
    },
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },

  -- re-color window split borders
  {
    "nvim-zh/colorful-winsep.nvim",
    opts = {
      highlight = { ctermfg = 2 },
    },
  },

  {
    "shellRaining/hlchunk.nvim",
    opts = {
      -- could modify these if I want to restrain hlchunk from certain languages?
      -- chunk = { support_filetypes = {}, exclude_filetypes = {} },
      indent = { enable = false },
      line_num = { enable = false },
      blank = { enable = false },
    },
  },

  -- nicer vim.ui.{input,select} (helpful when using noice, which changes UI a lot)
  {
    "stevearc/dressing.nvim",
    event = "VeryLazy",
    opts = {
      input = { enabled = false },
    },
  },

  -- experiment with noice
  {
    "folke/noice.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
      {
        "rcarriga/nvim-notify",
        opts = {
          -- override notify to use my settings for floating windows.
          on_open = function (win)
            local config = vim.api.nvim_win_get_config(win)
            config.border = "single"
            vim.api.nvim_win_set_config(win, config)
          end,
        },
      },
    },
    opts = {
      views = {
        -- use square borders for noice dialogs
        cmdline_popup = { border = { style = "single" } },
        hover = { border = { style = "single" } },
        popupmenu = { border = { style = "single" } },
      },

      routes = {
        {
          -- hide buf written messages
          filter = {
            event = "msg_show",
            kind = "",
            find = "written",
          },
          opts = { skip = true },
        },
        {
          -- shut up i'm not using termguicolors until i figure out wal.vim
          filter = {
            find = "Opacity changes require termguicolors to be set.",
          },
          opts = { skip = true },
        },
        {
          -- ignore hlchunk complaining about missing parsers
          filter = {
            find = "no parser for",
          },
          opts = { skip = true },
        }
      },

      lsp = {
        signature = {
          enabled = false,
        },
      },

      presets = {
        command_palette = true,
        long_message_to_split = true,
        lsp_doc_border = true,
      },
    },
  },

  -- animation of common actions (cursor movement, scroll, window open/close/resize)
  {
    "echasnovski/mini.animate",
    opts = {
      scroll = { enable = false },
      resize = { enable = false },
    },
  },
}
