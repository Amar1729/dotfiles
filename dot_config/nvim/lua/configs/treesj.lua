local tsj = require("treesj")
local tsj_utils = require("treesj.langs.utils")

local opts = {
    both = {
        last_separator = false,
    },
    join = {
        space_in_brackets = false,
    },
}

tsj.setup({
    langs = {
        python = {
            -- override defaults: when splitting params/args, ensure last arg
            -- has a trailing comma (cleaner diffs)
            parameters = tsj_utils.set_preset_for_list(opts),
            argument_list = tsj_utils.set_preset_for_list(opts),
        },
    },
})
