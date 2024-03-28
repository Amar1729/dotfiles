-- tree-sitter

-- for compiling TS grammar for justfiles
require("nvim-treesitter.install").compilers = { "gcc-11" }

require("nvim-treesitter.configs").setup {
    -- "all"  | {"list of languages"}
    ensure_installed = {
      "bash",
      "c",
      "cmake",
      "cpp",
      "dockerfile",
      "git_config",
      "git_rebase",
      "gitattributes",
      "gitcommit",
      "gitignore",
      "go",
      "graphql",
      "groovy",
      "hjson",
      "html",
      "http",
      "java",
      "javascript",
      "jq",
      "json",
      -- "just",
      "luadoc",
      "make",
      "markdown",
      "markdown_inline",
      "mermaid",
      "nix",
      -- norg fails 11/22/23 because of a compilation error in nvim-treesitter compile script
      -- "norg",
      "ocaml",
      "perl",
      "puppet",
      "python",
      -- for ts playground (:InspectTree)
      "query",
      "regex",  -- ??
      "rst",
      "ruby",
      "rust",
      "sql",
      "toml",
      "typescript",
      "vimdoc",
      "yaml",
    },
    -- ignore_install = { "d", "julia", "phpdoc", "php", "t32" },
    sync_install = false,

    highlight = {
        enable = true,
        disable = {},
        additional_vim_regex_highlighting = false,
    },

    -- Note: i use another plugin (currently, syntax-tree-surfer) for moving through nodes once
    -- a selection has been started.
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = "<C-Space>",
            node_incremental = "<C-Space>",
            scope_incremental = "<M-p>",
            node_decremental = "<BS>",
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
                ["aF"] = "@function.outer",
                ["iF"] = "@function.inner",
                ["ac"] = "@class.outer",
                ["ic"] = "@class.inner",
                ["ip"] = "@parameter.inner",
                ["ap"] = "@parameter.outer",

                ["iv"] = "@assignment.rhs",
                ["ik"] = "@assignment.lhs",
                ["in"] = "@number.inner",
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

    -- built-in (:Inspect, :InspectTree, and :EditQuery)
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

    -- lint playground queries
    query_linter = {
        enable = true,
        use_virtual_text = true,
        lint_events = { "InsertLeave" },
    },
}
