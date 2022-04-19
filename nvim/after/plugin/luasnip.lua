local ok, ls = pcall(require, "luasnip")
if not ok then
	return nil
end

vim.cmd("source ~/.config/nvim/snippets/snippets.lua")

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

vim.keymap.set("n", "<Space><Space>s", "<cmd>luafile ~/.config/nvim/snippets/snippets.lua<CR>")

local types = require("luasnip.util.types")

ls.config.set_config({
	history = true,
	-- Update more often, :h events for more info.
	updateevents = "TextChanged,TextChangedI",
	ext_opts = {
		[types.choiceNode] = {
			active = {
				virt_text = { { " <choice>", "CursorLine" } },
			},
		},
	},
})
