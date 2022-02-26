local ok, ls = pcall(require, "luasnip")
if not ok then
	return nil
end

-- local snip = ls.snippet
-- local sn = ls.snippet_node
-- local isn = ls.indent_snippet_node
-- local t = ls.text_node
-- local i = ls.insert_node
-- local f = ls.function_node
-- local c = ls.choice_node
-- local d = ls.dynamic_node
-- local r = ls.restore_node
-- local events = require("luasnip.util.events")



ls.filetype_extend("all", { "_" })
require("luasnip.loaders.from_snipmate").load()

vim.keymap.set({ "i", "s" }, "<c-j>", function()
	if ls.expand_or_jumpable() then
		ls.expand_or_jump()
	end
end, { silent = true })

vim.keymap.set({ "i", "s" }, "<c-k>", function()
	if ls.jumpable(-1) then
		ls.jump(-1)
	end
end, { silent = true })

vim.keymap.set({ "i" }, "<c-h>", function()
	if ls.choice_active() then
		ls.change_choice(1)
	end
end, { silent = true })


require("luasnip.loaders.from_vscode").load({ paths = { vim.fn.stdpath('config').."/snippets" } })

vim.cmd("source ~/.config/nvim/snippets/snippets.lua")
vim.keymap.set("n", "<Space><Space>s", "<cmd>source ~/.config/nvim/snippets/snippets.lua<CR>")
