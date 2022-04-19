-- Setup nvim-cmp.
local ok, cmp = pcall(require, "cmp")
if not ok then
	return nil
end

cmp.setup({
	completion = {
		autocomplete = true,
	},
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
		end,
	},
	mapping = cmp.mapping.preset.insert({
		["<C-Space>"] = cmp.mapping.complete(),
	}),
	-- {

	-- ["<C-n>"] = mapping(mapping.select_next_item({ behavior = types.cmp.SelectBehavior.Insert }), { "i", "c" }),
	-- ["<C-p>"] = mapping(mapping.select_prev_item({ behavior = types.cmp.SelectBehavior.Insert }), { "i", "c" }),
	-- ["<C-d>"] = mapping(mapping.scroll_docs(-4), { "i", "c" }),
	-- ["<C-f>"] = mapping(mapping.scroll_docs(4), { "i", "c" }),
	-- ["<C-Space>"] = mapping(mapping.complete(), { "i", "c" }),
	-- ["<C-e>"] = mapping({
	-- i = mapping.abort(),
	-- c = mapping.close(),
	-- }),
	-- -- Accept currently selected item. If none selected, `select` first item.
	-- -- Set `select` to `false` to only confirm explicitly selected items.
	-- ["<CR>"] = mapping.confirm({ select = false }),
	-- },
	sources = cmp.config.sources({
		{ name = "luasnip" },
		{ name = "nvim_lsp" },
		{
			name = "buffer",
			option = {
				get_bufnrs = function()
					return vim.api.nvim_list_bufs()
				end,
			},
		},
		{ name = "path" },
	}),
})

-- -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
-- cmp.setup.cmdline("/", {
-- 	sources = {
-- 		{ name = "buffer" },
-- 	},
-- })

-- -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
-- cmp.setup.cmdline(":", {
-- 	sources = cmp.config.sources({
-- 		{ name = "path" },
-- 	}, {
-- 		{ name = "cmdline" },
-- 	}),
-- })
