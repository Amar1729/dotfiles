-- NOTE: mapleader set by core.options

-- ---- ---- ---- ---- ---- ---- ---- ----
-- ---- Helper functions
-- ---- ---- ---- ---- ---- ---- ---- ----

local global_opts = { noremap = true, silent = true }

local keymap = function(mode, lhs, rhs, options)
    local opts = options or global_opts
    vim.api.nvim_set_keymap(mode, lhs, rhs, opts)
end

-- ---- ---- ---- ---- ---- ---- ---- ----
-- ---- Vanilla keybindings
-- ---- ---- ---- ---- ---- ---- ---- ----

-- Remove all trailing whitespace (takes a second)
keymap("n", "<leader>w", "<cmd>let _s=@/<Bar>:%s/\\s\\+$//e<Bar>:let @/=_s<Bar><CR>")

-- move to prev buffer and kill the previous one
-- (keeps window layout if the closed buffer isn't in other windows)
vim.keymap.set("n", "<leader>b", function ()
    local curbuf = vim.api.nvim_get_current_buf()

    if vim.fn.bufnr("#") > 0 then
        vim.cmd.execute([["normal! \<C-o>"]])
    else
        vim.api.nvim_command("bprev")
    end

    vim.api.nvim_buf_delete(curbuf, { force = true })
end)

-- center search results
-- */# searches are centered below, in hlslens keybinds
keymap("n", "n", "nzz")
keymap("n", "N", "Nzz")
keymap("n", "<C-d>", "<C-d>zz")
keymap("n", "<C-u>", "<C-u>zz")

-- LSP (note lsp is built-in functionality)
vim.keymap.set("n", "<space>e", vim.diagnostic.open_float)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist)

-- maybe this should be defined as on_attach?
local diagnostics_shown = 1
local toggle_vim_diagnostic = function()
    if diagnostics_shown == 1 then
        vim.diagnostic.config({virtual_text = false, underline = false})
        diagnostics_shown = 0
    else
        vim.diagnostic.config({virtual_text = true, underline = true})
        diagnostics_shown = 1
    end
end

-- 'yoe' still show gutter diagnostic signs; ']oe' will hide entirely
vim.keymap.set("n", "yoe", toggle_vim_diagnostic)
vim.keymap.set("n", "[oe", vim.diagnostic.show)
vim.keymap.set("n", "]oe", vim.diagnostic.hide)

-- override right-click popupmenu with some LSP stuff
-- (is there a lua equivalent yet for unmenu and amenu?)
vim.cmd([[ 
unmenu PopUp.Paste
unmenu PopUp.Select\ All
unmenu PopUp.-1-
unmenu PopUp.How-to\ disable\ mouse
anoremenu PopUp.Diagnostic :lua vim.diagnostic.open_float()<CR>
anoremenu PopUp.Rename :lua vim.lsp.buf.rename()<CR>
anoremenu PopUp.TypeDefinition :lua vim.lsp.buf.type_definition()<CR>
]])

-- clear stuff
-- https://www.reddit.com/r/neovim/comments/zmu22y/uses_for_escape_in_normal_mode/
vim.keymap.set("n", "<Esc>", function()
    -- clear notifications
	require("notify").dismiss()
    -- clear highlights
	vim.cmd.nohlsearch()
end)

-- chmod current file to executable
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })


-- ---- ---- ---- ---- ---- ---- ---- ----
-- ---- Plugin-provided keybindings
-- ---- ---- ---- ---- ---- ---- ---- ----

-- several plugins have their keymaps defined during setup() or as on_attach:
-- tree-sitter
-- nvim-cmp
-- gitsigns

-- undotree
keymap("n", "<leader>u", "<cmd>UndotreeToggle<CR>", { desc = "UndotreeToggle" })

-- conceal
vim.keymap.set("n", "<leader>tc", function()
    require("conceal").toggle_conceal()
end, { silent = true, desc = "toggle conceal" })

-- telescope

-- try to find git_files; otherwise fall back to regular find_files
local project_files = function()
    local opts = {} -- define here if you want to define something
    local ok = pcall(require("telescope.builtin").git_files, opts)
    if not ok then require("telescope.builtin").find_files(opts) end
end

vim.keymap.set("n", "<c-p>", project_files)
keymap("n", "<leader>ff", "<cmd>Telescope find_files<CR>")
keymap("n", "<c-f>", "<cmd>Telescope egrepify<CR>")
keymap("n", "<Tab>", "<cmd>Telescope buffers<CR>")

-- ssr
vim.keymap.set(
    { "n", "x" },
    "<leader>sr",
    function() require("ssr").open() end,
    { desc = "Structural Replace" }
)

-- hlslens
keymap("n", "*", "", {
    callback = function()
        vim.fn.execute("normal! *Nzz")
        require'hlslens'.start()
    end,
})

keymap("n", "#", "", {
    callback = function()
        vim.fn.execute("normal! #Nzz")
        require'hlslens'.start()
    end,
})

-- dadbod
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "sql", "mysql", "plsql" },
    callback = function()
        -- for some reason, vim.keymap.set doesn't work?
        -- vim.keymap.set("v", "<leader>D", "<cmd>DB<cr>", { silent = true, buffer = true })
        vim.cmd [[ vnoremap <leader>D :DB<CR> ]]
    end,
})

-- dadbod-ui
vim.keymap.set("n", "<leader>D", "<cmd>DBUI<CR>", global_opts)

-- rec'd by nvim-various-textobjs: open URLs
vim.keymap.set("n", "gx", function ()
    require("various-textobjs").url() -- select URL
    local foundURL = vim.fn.mode():find("v")

    -- if not found in proximity, search whole buffer via urlview.nvim instead
    if not foundURL then
        vim.cmd.UrlView("buffer")
        return
    end

    -- retrieve URL with the z-register as intermediary
    vim.cmd.normal { '"zy', bang = true }
    local url = vim.fn.getreg("z")

    -- open with the OS-specific shell command
    local opener
    if vim.fn.has("macunix") == 1 then
        opener = "open"
    elseif vim.fn.has("linux") == 1 then
        opener = "xdg-open"
    elseif vim.fn.has("win64") == 1 or vim.fn.has("win32") == 1 then
        opener = "start"
    end
    local openCommand = string.format ("%s '%s' >/dev/null 2>&1", opener, url)
    os.execute(openCommand)
end, {desc = "Smart URL Opener"})

-- syntax-surfer-tree
-- Note: my bindings for tree sitter already include an init-selection, so i don't have to bind STSSelectCurrentNode
vim.keymap.set("x", "J", "<cmd>STSSelectNextSiblingNode<CR>", global_opts)
vim.keymap.set("x", "K", "<cmd>STSSelectPrevSiblingNode<CR>", global_opts)
vim.keymap.set("x", "H", "<cmd>STSSelectParentNode<CR>", global_opts)
-- this will override the various-textobjs bind for URLs
vim.keymap.set("x", "L", "<cmd>STSSelectChildNode<CR>", global_opts)
