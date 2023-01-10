-- plugin set up and configuration
-- NOTE: I use the defaults for most lua plugins, which only requires a call to .setup()
-- for other more complex configurations (e.g. treesitter and nvim-cmp) I keep the
-- configurations in a separate config/ module to keep this file straightforward.

local fn = vim.fn

local check_os = function(target)
    local uname = vim.api.nvim_command_output("!uname -s"):gsub("%s+", "")
    return uname == target
end

local ensure_packer = function ()
    local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
    if fn.empty(fn.glob(install_path)) > 0 then
        print("Installing packer ...")
        fn.system({
            "git",
            "clone",
            "--depth",
            "1",
            "https://github.com/wbthomason/packer.nvim",
            install_path,
        })
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end

local PACKER_BOOTSTRAP = ensure_packer()

-- local status_ok, packer = pcall(require, "packar")
-- if not status_ok then
--     return
-- end

local packer = require("packer")

packer.init({
    display = {
        open_fn = function()
            return require("packer.util").float({ border = "single" })
        end,
    },
})

return packer.startup(function(use)
    -- let packer manage itself
    use {"wbthomason/packer.nvim"}

    -- ---- Theming and UI changes
    -- ---- ---- ---- ---- ---- ----

    -- gruvbox colorscheme
    -- use {"morhetz/gruvbox"}

    -- pywal vim colorscheme
    use {"dylanaraps/wal.vim"}

    -- statusline
    use {
        "nvim-lualine/lualine.nvim",
        config = function() require("configs.lualine") end,
    }

    -- re-color window split borders
    use {
        "nvim-zh/colorful-winsep.nvim",
        config = function()
            require("colorful-winsep").setup({
                highlight = {
                    ctermfg = 2,
                },
            })
        end,
    }

    -- experiment with noice
    use {
        "folke/noice.nvim",
        config = function ()
            require("noice").setup({
                routes = {
                    -- {
                    --     -- notify (macro) recording messages
                    --     view = "notify",
                    --     filter = { event = "msg_showmode", find = "recording @" },
                    -- },
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
            })
        end,
        requires = {
            "MunifTanjim/nui.nvim",
            "rcarriga/nvim-notify",
        },
    }


    -- ---- Tree-Sitter
    -- ---- ---- ---- ---- ---- ----

    -- use tree-sitter for language features
    use {
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate",
        config = function() require "configs.treesitter" end,
    }

    use {
        "nvim-treesitter/nvim-treesitter-context",
        after = "nvim-treesitter",
    }

    use {
        "nvim-treesitter/nvim-treesitter-textobjects",
        after = "nvim-treesitter",
    }

    -- more textobjects
    use {
        "echasnovski/mini.ai",
        config = function()
            require("mini.ai").setup()
        end,
    }

    -- more textobjects
    use {
        "chrisgrieser/nvim-various-textobjs",
        config = function()
            require("various-textobjs").setup({
                useDefaultKeymaps = true,
            })
        end,
    }

    use {
        "https://git.sr.ht/~p00f/nvim-ts-rainbow/",
        after = "nvim-treesitter",
    }

    -- display AST, write TS queries for buffer
    use {
        "nvim-treesitter/playground",
        after = "nvim-treesitter",
    }

    -- conceal (horizontally fold) keywords
    use {
        "Jxstxs/conceal.nvim",
        requires = "nvim-treesitter/nvim-treesitter",
        config = function()
            -- default: lua and python are enabled (and a few c keywords)
            require("conceal").setup({})

            -- run this whenever i change queries
            -- require("conceal").generate_conceals()
        end,
    }


    -- ---- Language-Server Protocol (LSP) plugins + Completions (nvim-cmp)
    -- Note: LSP functionality is built-in to neovim. these plugins simply enhance its ux
    -- Since completion setup is tied closely with LSP, I keep them in the same section.
    -- ---- ---- ---- ---- ---- ----

    -- standard configs for popular LSP servers
    use {
        "neovim/nvim-lspconfig",
    }

    use {
        "hrsh7th/nvim-cmp",
        after = "nvim-lspconfig",
    }
    use {
        "hrsh7th/cmp-nvim-lsp",
        after = {"nvim-lspconfig", "nvim-cmp"},

        -- this config sets up nvim-lspconfig, nvim-cmp, and cmp-nvim-lsp
        -- so should be run after all those three are loaded
        config = function() require("configs.cmp") end,
    }
    use {
        "hrsh7th/cmp-buffer",
        after = {"nvim-lspconfig", "nvim-cmp"},
    }
    use {
        "hrsh7th/cmp-path",
        after = {"nvim-lspconfig", "nvim-cmp"},
    }
    use {
        "hrsh7th/cmp-cmdline",
        after = {"nvim-lspconfig", "nvim-cmp"},
    }

    -- snippets for nvim-cmp, and use vscode snips from friendly-snippets
    use {
        "L3MON4D3/LuaSnip",
        tag = "v1.*",
        config = function()
            require("luasnip.loaders.from_vscode").lazy_load()
        end,
    }
    use { "saadparwaiz1/cmp_luasnip" }
    use { "rafamadriz/friendly-snippets" }

    -- auto-popup signature_help while in insert mode inside a method's param list
    use {
        "ray-x/lsp_signature.nvim",
        after = "nvim-lspconfig",
        config = function()
            require("lsp_signature").setup({ bind = true })
        end,
    }


    -- ---- UX changes and add-ons
    -- ---- ---- ---- ---- ---- ----

    -- repeat motions from plugins and elsewhere
    use { "tpope/vim-repeat" }

    -- telescope - arbitrary fuzzy-searching over lists (e.g. buffers or files in workspace)
    use {
        "nvim-telescope/telescope.nvim",
        branch = "0.1.x",
        requires = {
            "nvim-lua/plenary.nvim",
        },
        config = function() require "configs.telescope" end,
        -- this loads after telescope extensions so it can register them in its config
        after = { "telescope-fzf-native.nvim", "telescope-luasnip.nvim" },
    }

    use {
        "nvim-telescope/telescope-fzf-native.nvim",
        run = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
    }

    -- search luasnip snippets from inside telescope
    use {
        "benfowler/telescope-luasnip.nvim",
    }

    -- git signs in gutter, management of hunks ;) and simple diff views
    use {
        "lewis6991/gitsigns.nvim",
        config = function() require "configs.gitsigns" end,
    }

    -- use git from inside vim (e.g. `:Git commit`)
    use { "tpope/vim-fugitive" }

    -- typewriter
    --use "Amar1729/vimty"}


    -- ---- Movement
    -- ---- ---- ---- ---- ---- ----

    -- many consistent bindings for movement and simple manipulations
    use { "tpope/vim-unimpaired" }

    -- tmux/vim interop
    use { "christoomey/vim-tmux-navigator" }

    -- jump through CamelCase, snake_case words better
    use { "bkad/CamelCaseMotion" }

    -- digraph-based search through visible buffer
    use {
        "ggandor/leap.nvim",
        config = function()
            require("leap").add_default_mappings()
        end,
    }

    -- multi-line f/t
    use {
        "ggandor/flit.nvim",
        after = "leap.nvim",
        config = function()
            require("flit").setup({
                labeled_modes = "n",
                special_keys = {
                    repeat_search = { "<Enter>" },
                },
                opts = {
                    special_keys = {
                        repeat_search = { "<Enter>" },
                    }
                },
            })
        end,
    }

    -- actions from a distance, using leap
    use {
        "ggandor/leap-spooky.nvim",
        after = "leap.nvim",
        config = function()
            require("leap-spooky").setup({ paste_on_remote_yank = true })
        end,
    }

    -- cool searching
    use {
        "kevinhwang91/nvim-hlslens",
        config = function()
            require("hlslens").setup({
                calm_down = false,
                nearest_only = true,
                virt_priority = 10,
            })
        end
    }


    -- ---- Text Manipulation
    -- ---- ---- ---- ---- ---- ----

    -- for surrounding phrases with characters
    use { "tpope/vim-surround" }

    -- undotree visualization/movement
    use { "mbbill/undotree" }

    -- TS-aware commenting
    use {
        "numToStr/Comment.nvim",
        config = function()
            require("Comment").setup()
        end,
    }

    -- TS-aware split/join
    use {
        "Wansmer/treesj",
        config = function() require "configs.treesj" end,
    }


    -- ---- Language-specific syntax support, completions:
    -- ---- ---- ---- ---- ---- ----

    -- vim wiki
    use {
        "vimwiki/vimwiki",
        config = function()
            vim.cmd([[
            let wiki_1 = {}
            let wiki_1.path = '~/Dropbox/wiki/'
            "let wiki_1.html_template = '~/public_html/template.tpl'
            "let wiki_1.nested_syntaxes = {'python': 'python', 'c++': 'cpp'}

            let wiki_2 = {}
            let wiki_2.path = '~/Documents/Personal/work_wiki/'
            "let wiki_2.index = 'main'

            let g:vimwiki_list = [wiki_1, wiki_2]
            ]])
        end,
    }

    -- chezmoi templating/support
    use {"alker0/chezmoi.vim"}

    -- development settings for lua files under nvim root
    -- setup() is done in ../configs/cmp.lua:208, before sumneko_lua gets setup
    use { "folke/neodev.nvim" }

    -- nice completion of xhtml tags
    use { "tpope/vim-ragtag" }

    -- sxhkd
    use {
        "kovetskiy/sxhkd-vim",
        -- TODO:
        -- cond = check_os("Linux"),
    }

    -- antlr files (.g4 and .g3)
    use {"dylon/vim-antlr"}

    -- powershell (ugh)
    use {"PProvost/vim-ps1"}

    -- skhd
    use {
        "amar1729/skhd-vim-syntax",
        -- TODO:
        -- cond = check_os("Darwin"),
    }


    -- if bootstrapping, run sync
    if PACKER_BOOTSTRAP then
        require("packer").sync()
    end
end)
