-- tree-sitter

require("nvim-treesitter.configs").setup {
    -- "all"  | {"list of languages"}
    ensure_installed = "all",
    ignore_install = { "phpdoc", "php" },
    sync_install = false,

    highlight = {
        enable = true,
        disable = {},
        additional_vim_regex_highlighting = false,
    },

    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = "<M-n>",
            node_incremental = "<M-n>",
            scope_incremental = "<M-p>",
            node_decremental = "<M-i>",
        }
    },

    indent = {
        enable = false,
    },

    -- provided by nvim-treesitter-textobjects plugin
    textobjects = {
        select = {
            enable = true,

            -- automatically jump forward to textobj
            lookahead = true,

            keymaps = {
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",
                ["ac"] = "@class.outer",
                ["ic"] = "@class.inner",
            },
        },

        -- TODO: neovim provides mappings for jumping over functions
        -- [[, ]], [m, ]M,
        -- should i add these as text object movements, or keep them as nvim-provided?
        move = {
            enable = true,
            set_jumps = true,

            goto_next_start = {
                ["]a"] = "@parameter.inner",
            },
            goto_next_end = {
                ["]A"] = "@parameter.outer",
            },
            goto_previous_start = {
                ["[a"] = "@parameter.inner",
            },
            goto_previous_end = {
                ["[A"] = "@parameter.outer",
            },
        },

        swap = {
            enable = true,

            swap_next = {
                ["<leader>a"] = "@parameter.inner",
            },
            swap_previous = {
                ["<leader>A"] = "@parameter.inner",
            },
        },
    },

    -- provided by p00f/nvim-ts-rainbow
    rainbow = {
        enable = true,
        extended_mode = true,
    },

    -- provided by nvim-treesitter/playground
    playground = {
        enable = true,
        disable = {},
        updatetime = 25,
        persist_queries = false,
        keybindings = {
            toggle_query_editor = "o",
            toggle_hl_groups = "i",
            toggle_injected_languages = "t",
            toggle_anonymous_nodes = "a",
            toggle_language_display = "I",
            focus_language = "f",
            unfocus_language = "F",
            update = "R",
            goto_node = "<cr>",
            show_help = "?",
        },
    },
}
