local cmd = vim.api.nvim_create_autocmd
local group = vim.api.nvim_create_augroup
local opts = { clear = true }

-- ---- ---- ---- ---- ---- ---- ---- ----
-- ---- Vanilla autocmds
-- ---- ---- ---- ---- ---- ---- ---- ----

-- copy unnamed register to system "+" reg after leaving vim
-- this is better than clipboard+=unnamedplus:
-- 1. Avoids copying register over every time it's written (slight perf hit)
-- 2. Don't want my system clipboard copied **into** vim (can just meta-v paste)
cmd({ "FocusLost", "VimLeavePre" },
    {
        pattern = "*",
        callback = function ()
            vim.fn.setreg('+', vim.fn.getreginfo('"'))
        end
    }
)
cmd({ "FocusGained", "VimEnter" },
    {
        pattern = "*",
        callback = function ()
            -- somewhat of a WIP but mostly works as i want right now
            -- save the current unnamed register so we don't silently overwrite it
            -- hacky:
            local pre = ""
            local incoming = ""
            if vim.fn.getreginfo('"').regcontents then
                for _, k in pairs(vim.fn.getreginfo('"').regcontents) do
                    pre = k
                end
            end
            if vim.fn.getreginfo('+').regcontents then
                for _, k in pairs(vim.fn.getreginfo('+').regcontents) do
                    incoming = k
                end
            end

            if pre ~= incoming then
                vim.fn.setreg('h', vim.fn.getreginfo('"'))
                vim.fn.setreg('"', vim.fn.getreginfo('+'))
            end
        end
    }
)

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

-- re-compile upon updates to plugin configuration
local group_packer = group("PackerUserConfig", opts)
cmd("BufWritePost",
    {
        group = group_packer,
        pattern = "plugins.lua",
        command = "source <afile> | PackerCompile",
    }
)

-- update quickfix
-- in addition to nvim-cmp []d bindings for moving, can still use []q from
-- vim-unimpaired if that's more comfortable (see mappings)
cmd("DiagnosticChanged",
    {
        pattern = "*",
        callback = function() vim.diagnostic.setqflist({open = false}) end,
    }
)

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
