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

local clean_join = {
    join = {
        space_in_brackets = false,
    },
}

local langs = {
    -- current config for python - try to match what `black` would do
    -- (e.g. trailing commas after last element in multiline obj)
    -- TODO - is it possible to recursive split only when cursor is on an
    -- object inside an object? eg [ [ x ] ] but not [ x [ ] ] ?
    python = {
        -- yes trailing comma on split
        array = tsj_utils.set_preset_for_list(opts),
        list = tsj_utils.set_preset_for_list(opts),
        dictionary = tsj_utils.set_preset_for_dict(opts),
        parameters = tsj_utils.set_preset_for_list(clean_join),
        argument_list = tsj_utils.set_preset_for_list(opts),

        -- no trailing comma on split
        -- don"t surround with spaces on join
        list_comprehension = tsj_utils.set_preset_for_args(clean_join),
        dictionary_comprehension = tsj_utils.set_preset_for_args(clean_join),
    },
}

tsj.setup({
    langs = langs,
})
