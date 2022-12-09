local cmd = vim.api.nvim_create_autocmd
local group = vim.api.nvim_create_augroup
local opts = { clear = true }

-- ---- ---- ---- ---- ---- ---- ---- ----
-- ---- Vanilla autocmds
-- ---- ---- ---- ---- ---- ---- ---- ----

-- save view, restore on open
local group_view = group("SaveView", opts)
cmd("BufWinLeave",
    {
        group = group_view,
        pattern = { "*.*" },
        command = "mkview",
    }
)
cmd("BufWinEnter",
    {
        group = group_view,
        pattern = { "*.*" },
        command = "silent! loadview",
    }
)

-- re-equalize splits on terminal resize
cmd("VimResized",
    {
        pattern = {"*"},
        command = "wincmd =",
    }
)

-- test if this is still necessary - explicitly set rc file ft
cmd("BufWinLeave",
    {
        pattern = "*rc",
        command = "set syntax=config",
    }
)


local group_templates = group("Templates", opts)
local make_template_cmd = function(pattern, ext)
    cmd("BufNewFile",
        {
            group = group_templates,
            pattern = pattern,
            command = "0r " .. vim.fn.stdpath("config") .. "/templates/skeleton." .. ext
        }
    )
end

make_template_cmd("*.py", "py")
make_template_cmd("*.sh", "bash")


-- ---- ---- ---- ---- ---- ---- ---- ----
-- ---- Plugin-provided autocmds
-- ---- ---- ---- ---- ---- ---- ---- ----

-- auto-write changes to chezmoi files
cmd("BufWritePost",
    {
        pattern = os.getenv('HOME') .. "/.local/share/chezmoi/*",
        -- :p resolves full path of file
        command = "!chezmoi apply --source-path <afile>:p",
    }
)


local group_antlr = group("SetAntlr", { clear = true })
cmd({"BufRead", "BufNewFile"},
    {
        group = group_antlr,
        pattern = {"*.g"},
        command = "set filetype=antlr3",
    }
)
cmd({"BufRead", "BufNewFile"},
    {
        group = group_antlr,
        pattern = {"*.g4"},
        command = "set filetype=antlr4",
    }
)
