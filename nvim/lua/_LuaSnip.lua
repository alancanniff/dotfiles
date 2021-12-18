local my = require('my_utils')
local luasnip = require('luasnip')
local snip = luasnip.snippet

-- local sn = ls.snippet_node
-- local isn = ls.indent_snippet_node
-- local t = ls.text_node
-- local i = ls.insert_node
-- local f = ls.function_node
-- local c = ls.choice_node
-- local d = ls.dynamic_node
-- local r = ls.restore_node
-- local events = require("luasnip.util.events")

luasnip.filetype_extend("all", { "_" })
require("luasnip.loaders.from_snipmate").load()
-- require("luasnip.loaders.from_snipmate").lazy_load() -- Lazy loading


-- vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
-- vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
-- vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
-- vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
-- vim.api.nvim_set_keymap("i", "<C-E>", "<Plug>luasnip-next-choice", {})
-- vim.api.nvim_set_keymap("s", "<C-E>", "<Plug>luasnip-next-choice", {})

    local noremap = { noremap=true, silent=true }
    local remap = { noremap=false, silent=true, expr=true }

    my.buf_map('i', '<Tab>', [[luasnip#expandable() ? '<Plug>luasnip-expand-snippet' : '<Tab>']], remap)
    my.buf_map('i', '<C-j>', [[<cmd>lua require('luasnip').jump(1)<Cr>]], noremap)
    my.buf_map('i', '<C-k>', [[<cmd>lua require'luasnip'.jump(-1)<Cr>]], noremap)
    my.buf_map('s', '<C-j>', [[<cmd>lua require('luasnip').jump(1)<Cr>]], noremap)
    my.buf_map('s', '<C-k>', [[<cmd>lua require('luasnip').jump(-1)<Cr>]], noremap)

-- imap <silent><expr> <C-E> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'
-- smap <silent><expr> <C-E> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'
