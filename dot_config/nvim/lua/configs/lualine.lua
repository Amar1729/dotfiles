-- ---- customize some theme colors
local custom_pywal = require("lualine.themes.pywal")

custom_pywal.normal.a.bg = 2
custom_pywal.normal.b.bg = 0

-- ---- customize some functions for display
local mode_map = {
    ['n'] = 'normie',
    ['s'] = 'do >',
    ['i'] = 'hardcore hacking',
    ['R'] = 'swappity swip',
    ['v'] = 'look',
    ['V'] = 'line look',
    [''] = 'block look',
    ['c'] = 'commando',
    ['t'] = 'powershell',
    ['nt'] = 'powershell ...',
}

local has_multiple_buffers = function ()
    local len = 0
    for buffer = 1, vim.fn.bufnr('$') do
        if vim.fn.buflisted(buffer) == 1 then
            len = len + 1

            -- early exit if we have more than 1 buffer
            if len > 1 then
                break
            end
        end
    end

    -- i'm sure it's inefficient to set this on every check
    -- is there a better way to re-hide the tabline if i close out buffers?
    if len < 2 then
        vim.cmd [[ set showtabline=1 ]]
        return false
    else
        vim.cmd [[ set showtabline=2 ]]
        return true
    end
end

-- ---- setup
require("lualine").setup {
    options = {
        theme = custom_pywal,
        section_separators = {
            left = '▊▌▎▏',
            right = '▏▎▌▊'
        },
        component_separators = {
            right = '▏▎',
            left = '▎▏',
        },
    },
    sections = {
        -- override a, b, x, y
        -- leave defaults for c (filename), z (row/col)
        lualine_a = {
            {
                -- rename our modes
                function ()
                    return mode_map[vim.api.nvim_get_mode().mode] or "__"
                end
            }
        },
        lualine_b = {
            -- default, with on_click overrides for branch/diff(?)/diagnostics
            {
                "branch",
                on_click = function() require("telescope.builtin").git_branches() end,
            },
            {
                "diff",
                on_click = function() package.loaded.gitsigns.diffthis() end,
            },
            {
                "diagnostics",
                on_click = function() vim.diagnostic.setloclist() end,
            },
            {
                function ()
                    local bookmark = " "
                    if require("grapple").exists() then
                        return bookmark .. require("grapple").key()
                    end
                    return bookmark
                end,
                -- cond = require("grapple").exists,
                cond = function () return pcall(require, "grapple") end,
                on_click = function() require("grapple").popup_tags() end,
            },
        },
        lualine_x = {
            {
                -- show statusline mode msgs in component x
                -- should this be pcall?
                require("noice").api.statusline.mode.get,
                cond = require("noice").api.statusline.mode.has,
                color = { fg = 3 },
            }
        },
        lualine_y = {
            {
                function() return '' end,
                cond = function()
                    return vim.bo.readonly
                end,
            },
        },
    },
    tabline = {
        lualine_a = {
            {
                -- show buffers if we have > 1
                'buffers',
                -- default max length (2/3) too short
                max_length = function () return vim.o.columns * 95 / 100 end,
                cond = has_multiple_buffers,
            }
        },
        lualine_z = {
            {
                -- show tabs if we have > 1
                'tabs',
                cond = function()
                    return vim.fn.tabpagenr('$') > 1
                end,
            },
        },
    },
}
