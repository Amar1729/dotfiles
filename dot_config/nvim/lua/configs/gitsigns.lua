require("gitsigns").setup({
    numhl = true,
    current_line_blame = true,
    current_line_blame_opts = { delay = 500 },

    on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        local function map(mode, lhs, rhs, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, lhs, rhs, opts)
        end

        -- navigation
        map("n", "]h", function()
                if vim.wo.diff then return "]h" end
                vim.schedule(function()
                    gs.next_hunk()
                    vim.api.nvim_feedkeys("zz", "n", false)
                end)
                return "<Ignore>"
            end, {expr=true})

        map("n", "[h", function()
                if vim.wo.diff then return "[h" end
                vim.schedule(function()
                    gs.prev_hunk()
                    vim.api.nvim_feedkeys("zz", "n", false)
                end)
                return "<Ignore>"
            end, {expr=true})

        -- actions
        map({"n", "v"}, "<leader>hs", ":Gitsigns stage_hunk<CR>")
        map({"n", "v"}, "<leader>hr", ":Gitsigns reset_hunk<CR>")
        map("n", "<leader>hS", gs.stage_buffer)
        map("n", "<leader>hu", gs.undo_stage_hunk)
        map("n", "<leader>hR", gs.reset_buffer)
        map("n", "<leader>hp", gs.preview_hunk)
        map("n", "<leader>hd", gs.diffthis)
        map("n", "<leader>hD", function() gs.diffthis("~") end)
        map("n", "yog", gs.toggle_current_line_blame)

        -- text object
        map({"o", "x"}, "ih", ":<C-u>Gitsigns select_hunk<CR>")
    end
})
