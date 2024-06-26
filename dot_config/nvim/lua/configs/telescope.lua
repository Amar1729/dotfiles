-- telescope searching

local actions = require("telescope.actions")
local telescope = require("telescope")

telescope.setup {
    defaults = {
      prompt_prefix = "󰼛 ",
      selection_caret = "󱞩 ",
      path_display = { filename_first = { reverse_directories = false } },

        -- trim leading space from matches
        vimgrep_arguments = {
            "rg",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
            "--trim" -- add this value
        },

        mappings = {
            i = {
                ["<esc>"] = actions.close,
                ["<C-u>"] = false
            },
        },

        extensions = {
            -- i dont think this needs to be specified?
            -- fzf,
            -- fzf = {},

            advanced_git_search = {},
        },
    },

    pickers = {
        git_files = {
            mappings = {
                i = { ["<Tab>"] = actions.to_fuzzy_refine }
            }
        }
    }
}

telescope.load_extension("fzf")
telescope.load_extension("egrepify")
telescope.load_extension("before")
telescope.load_extension("neoclip")
telescope.load_extension("advanced_git_search")
