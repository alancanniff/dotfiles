-- vim help links
-- luasnip-snippets

--[[
Basic snippet format!
--]]
-- s({
--   trig = {},
--   name = {},
--   dscr = {}
--   }, 
--   fmt([[ {} ]], {})
-- )

local ok, ls = pcall(require, "luasnip")
if not ok then
	return nil
end

print("Loading snippets")

local s = ls.snippet
local sn = ls.snippet_node
-- local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
-- local r = ls.restore_node
-- local events = require("luasnip.util.events")
-- local ai = require("luasnip.nodes.absolute_indexer")
-- local utils = require("luasnip_snippets.utils")
local fmt = require("luasnip.extras.fmt").fmt

ls.add_snippets("all", {
	s(
		"fmt1",
		fmt("To {title} {} {}.", {
			i(2, "Name"),
			i(3, "Surname"),
			title = c(1, { t("Mr."), t("Ms.") }),
		})
	),
})

local function filebase(_, snip)
	return snip.env.TM_FILENAME_BASE
end

local function filename(_, snip)
	return snip.env.TM_FILENAME
end

local function option_text(args)
	local opt_string = [[
    --XYZ)
    	if [ "\$2" ]; then
    	XYZ=\$2
    	shift
    	else
    	die 'ERROR: "--XYZ" requires a non-empty option argument.'
    	fi
    	;;
    --XYZ=?*)
    	XYZ=\${1#*=} # Delete everything up to "=" and assign the remainder.
    	;;
    # Handle the case of an empty --file=
    --XYZ=)
    	echo 'ERROR: "--XYZ" requires a non-empty option argument.'
    	exit 1
    	;;

    ]]

	return vim.split(opt_string:gsub("XYZ", args[1][1]), "\n")
end

ls.add_snippets("sh", {
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
	s(
		"topt",
		fmt(
			[[
function usage () {{
echo "usage :  $${{0:0}} [options] [--]
options:
-h|--help		Display this message
-v|--version	Display script version

--{}			{}"

}}	 # ----------  end of function usage  ----------

while :; do
case \$1 in
	 # Takes an option argument; ensure it has been specified.
	{}

	-h|-\?|--help)
		usage; exit 0;;	# Display a usage synopsis.
	-v|--verbose)
		verbose=\$((verbose + 1))  # Each -v adds 1 to verbosity.
		;;
	--)		 # End of all options.
		shift
		break
		;;
	-?*)
		printf 'ERROR: Unknown option (ignored): %s\n' "\$1" >&2
		exit 1
		;;
	*)		 # Default case: No more options, so break out of the loop.
		break
esac

shift
done
]],
			{ i(1), i(2), f(option_text, 1) }
		)
	),
})

ls.add_snippets("tcl", {
	ls.parser.parse_snippet("dbg", [[puts "Debug: $1"$0]]),
})

ls.add_snippets("markdown", {
	s("mailto", fmt("[{}](mailto:{}){}", { i(1, "text"), i(2, "email"), i(0) })),
	s("url", fmt("[{}]({}){}", { i(1, "text"), i(2, "url"), i(0) })),
	s("ttt", { t("```"), i(1), t({ "", "```" }), i(0) }),
})

ls.add_snippets("lua", {
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
})

ls.add_snippets("systemverilog", {
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
				f(filebase, {}),
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
})
