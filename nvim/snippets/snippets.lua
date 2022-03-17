-- vim help links
-- luasnip-snippets

local ok, ls = pcall(require, "luasnip")
if not ok then
	return nil
end

local s = ls.snippet
local sn = ls.snippet_node
-- local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
-- local d = ls.dynamic_node
-- local r = ls.restore_node
-- local events = require("luasnip.util.events")
-- local ai = require("luasnip.nodes.absolute_indexer")
-- local utils = require("luasnip_snippets.utils")
local fmt = require("luasnip.extras.fmt").fmt

local function filename(_, snip)
	return snip.env.TM_FILENAME_BASE
end

ls.snippets = {
	sh = {
		s(
			"foreach",
			fmt(
				[[
	arr=({})

	for value in "\${{arr[@]}}"; do
		{}
	done
	]],
				{ i(1), i(0) }
			)
		),
	},

	tcl = {
		ls.parser.parse_snippet("dbg", [[puts "Debug: $1"$0]]),
	},
	markdown = {
		s("mailto", fmt("[{}](mailto:{}){}", { i(1, "text"), i(2, "email"), i(0) })),
		s("url", fmt("[{}]({}){}", { i(1, "text"), i(2, "url"), i(0) })),
		s("ttt", { t("```"), i(1), t({ "", "```" }), i(0) }),
	},
	lua = {
		s(
			"guard",
			fmt(
				[[
		local ok, {} = pcall(require, "{}")
		if not ok then
			return nil
		end{}
		]],
				{
					f(function(args)
						return args[1][1]
					end, 1),
					i(1),
					i(0),
				}
			)
		),
	},
	systemverilog = {
		s(
			"mod",
			fmt(
				[[
		/**
		 *
		 */
		module {} {}(
			{}
		);
			{}
		endmodule
		]],
				{
					f(filename, {}),
					c(1, { t(""), sn(1, { t("#("), i(1), t({ "", ")" }) }) }),
					i(2),
					i(0),
				}
			)
		),
		s(
			"ifg",
			fmt(
				[[
		generate
			if ({}) begin : gen_{}
				{}
			end
		endgenerate
		]],
				{ i(1), i(2), i(0) }
			)
		),
	},
}
