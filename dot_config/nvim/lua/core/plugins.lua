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

    -- Themes:

    -- gruvbox colorscheme
    -- use {"morhetz/gruvbox"}

    -- pywal vim colorscheme
    use {"dylanaraps/wal.vim"}

    -- powerline that works with neovim
    use {
        "vim-airline/vim-airline",
        config = function() require("configs.airline") end,
    }
    use {"vim-airline/vim-airline-themes"}

    use {
        "nvim-zh/colorful-winsep.nvim",
        commit = "9a47493",
        config = function()
            require("colorful-winsep").setup()

            -- https://github.com/nvim-zh/colorful-winsep.nvim/issues/21
            vim.cmd [[
                augroup NvimSeparatorPost
                    autocmd!
                    autocmd WinEnter * hi NvimSeparator ctermfg=2
                augroup END
            ]]
        end,
    }


    -- Engines, code style:

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

    use {
        "https://git.sr.ht/~p00f/nvim-ts-rainbow/",
        after = "nvim-treesitter",
    }

    -- lsp-based code completions
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

    -- for calling signature_help while in insert mode
    use {
        "ray-x/lsp_signature.nvim",
        after = "nvim-lspconfig",
        config = function()
            require("lsp_signature").setup({ bind = true })
        end,
    }


    -- Quality of life:

    -- tmux/vim interop
    use {"christoomey/vim-tmux-navigator"}

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

    -- (lua) git signs (replaced airblade/gitgutter)
    use {
        "lewis6991/gitsigns.nvim",
        config = function() require "configs.gitsigns" end,
    }

    -- use git from inside vim
    use {"tpope/vim-fugitive"}

    -- for surrounding phrases with characters
    use {"tpope/vim-surround"}

    -- TS-aware commenting
    use {
        "numToStr/Comment.nvim",
        config = function()
            require("Comment").setup()
        end,
    }

    -- nice completion of xhtml tags
    use {"tpope/vim-ragtag"}

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

    -- typewriter
    --use "Amar1729/vimty"}

    -- general improvements
    use {"tpope/vim-unimpaired"}
    use {"tpope/vim-repeat"}

    -- plugins for movement
    use {"bkad/CamelCaseMotion"}

    use {
        "ggandor/leap.nvim",
        config = function()
            require("leap").add_default_mappings()
        end,
    }

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

    -- TS-aware split/join
    use {
        "Wansmer/treesj",
        config = function() require "configs.treesj" end,
    }


    -- Language-specific syntax support, completions:

    -- chezmoi templating/support
    use {"alker0/chezmoi.vim"}

    -- development settings for lua files under nvim root
    use {
        "folke/neodev.nvim",
        config = function() require "configs.neodev" end,
    }

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
