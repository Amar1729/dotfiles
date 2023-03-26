-- personal snippets

local ls = require('luasnip')
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

-- custom snippet for work copyright statement
-- TODO: is there a way to get 'commentstring' and insert it before every line?
ls.add_snippets("all", {
    s("COPYRIGHT", {
        t("COPYRIGHT NOTICE"),
        t({"", "", ""}),
        t("Copyright (C) "),
        i(1, "YEAR"),
        t(" The Johns Hopkins University Applied Physics Laboratory LLC."),
        t({"", ""}),
        t("All Rights Reserved."),
        t({"", "", ""}),
        t("For permission to use, modify, or reproduce, contact the"),
        t({"", ""}),
        t("Office of Technology Transfer at JHU/APL."),
    }),
})
