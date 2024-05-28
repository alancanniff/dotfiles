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

local function get_architecture_name(_, snip)
	if string.find(snip.env.TM_FILENAME_BASE, "_tb.vhd") then
		return "sim"
	end
	return "rtl"
end

local function filebase(_, snip)
	return snip.env.TM_FILENAME_BASE
end

local function filename(_, snip)
	return snip.env.tm_filename
end

local function get_node(args)
	return args[1][1]
end

local function type_name_to_array(args)
	return args[1][1]:gsub("_t$", "_a")
end

local function get_variable_from_node(args)
	return args[1][1]:gsub("-", "_")
end

local function debug_args(args)
	print(vim.inspect(args))
	return args[1][1]
end

local recurring_optiong
recurring_optiong = function()
	return sn(nil, {
		c(1, {
			-- important!! Having the sn(...) as the first choice will cause infinite recursion.
			t({ "" }),
			-- The same dynamicNode as in the snippet (also note: self reference).
			sn(
				nil,
				fmt(
					[[
--{})
        {}=1
        ;;
    {}
]],
					{ i(1), f(get_variable_from_node, 1), d(2, recurring_optiong) }
				)
			),
			sn(
				nil,
				fmt(
					[[
--{})
        if [ "$2" ]; then
            {}=$2
            shift
        else
            echo 'ERROR: "--{}" requires a non-empty option argument.'
            usage
            exit 1
        fi
        ;;
    --{}=?*)
        # Delete everything up to "=" and assign the remainder.
        {}=${{1#*=}}
        ;;
    # Handle the case of an empty --opt=
    --{}=)
        echo 'ERROR: "--{}" requires a non-empty option argument.'
        usage
        exit 1
        ;;
    {}
]],
					{
						i(1),
						f(get_variable_from_node, 1),
						f(get_node, 1),
						f(get_node, 1),
						f(get_variable_from_node, 1),
						f(get_node, 1),
						f(get_node, 1),
						d(2, recurring_optiong),
					}
				)
			),
		}),
	})
end

ls.add_snippets("all", {
	---------------------------------------------------------------------------
	s(
		"fmt1",
		fmt("To {title} {} {}.", {
			i(2, "Name"),
			i(3, "Surname"),
			title = c(1, { t("Mr."), t("Ms.") }),
		})
	),
	---------------------------------------------------------------------------
})

ls.add_snippets("sh", {
	---------------------------------------------------
	s(
		"foreach",
		fmt(
			[[
	arr=({})

	for value in "${{arr[@]}}"; do
		{}
	done
	]],
			{ i(1), i(0) }
		)
	),

	---------------------------------------------------
	s(
		"opt",
		fmt(
			[[

function usage () {{
    echo "usage :  $(basename $0) [options] [--]
    options:
    -h|--help       Display this message
    -v|--version    Display script version
    {}
    "

}}   # ----------  end of function usage  ----------

while :; do

    case $1 in
    {}
	-h|--help)
		usage;
        exit 0
        ;;
	--)		 # End of all options.
		shift
		break
		;;
	-?*)
		printf 'ERROR: Unknown option (ignored): %s\n' "$1" >&2
        usage
		exit 1
		;;
	*)		 # Default case: No more options, so break out of the loop.
		break
    esac
    shift
done
{}
    ]],
			{ i(2), d(1, recurring_optiong, {}), i(0) }
		)
	),
	---------------------------------------------------------------------------
})

ls.add_snippets("tcl", {
	---------------------------------------------------------------------------
	ls.parser.parse_snippet("dbg", [[puts "Debug: $1"$0]], {}),
	---------------------------------------------------------------------------
	ls.parser.parse_snippet(
		"lsp",
		[[
source ~/.config/scripts/lsp.tcl
lsp::create_config "../hdl-prj.json"
    ]],
		{}
	),
})

ls.add_snippets("markdown", {
	---------------------------------------------------------------------------
	s("mailto", fmt("[{}](mailto:{}){}", { i(1, "text"), i(2, "email"), i(0) })),
	---------------------------------------------------------------------------
	s("url", fmt("[{}]({}){}", { i(1, "text"), i(2, "url"), i(0) })),
	---------------------------------------------------------------------------
	s("codeblock", { t("```"), i(1), t({ "", "```" }), i(0) }),
	---------------------------------------------------------------------------
})

ls.add_snippets("lua", {
	---------------------------------------------------------------------------
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
	---------------------------------------------------------------------------
})

ls.add_snippets("systemverilog", {
	---------------------------------------------------------------------------
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
	---------------------------------------------------------------------------
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
	---------------------------------------------------------------------------
})

--[[
]]
--
ls.add_snippets("vhdl", {
	---------------------------------------------------------------------------
	s(
		"header",
		fmt(
			[[
-------------------------------------------------------------------------------
-- Title      : {}
-------------------------------------------------------------------------------
-- Copyright (c) 2024 Psonic.  All rights reserved.
-------------------------------------------------------------------------------
-- Description: {}
-------------------------------------------------------------------------------
{}
]],
			{
				i(1),
				i(2),
				i(0),
			}
		)
	),
	---------------------------------------------------------------------------
	s(
		"ent",
		fmt(
			[[
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity {} is
    generic (
    );
    port (
    );
end entity {};

{}
]],
			{
				f(filebase, {}),
				f(filebase, {}),
				i(0),
			}
		)
	),
	---------------------------------------------------------------------------
	s(
		"pkg",
		fmt(
			[[
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package {} is
{}
end package {};

package body {} is
end package body {};
]],
			{
				f(filebase, {}),
				i(0),
				f(filebase, {}),
				f(filebase, {}),
				f(filebase, {}),
			}
		)
	),
	---------------------------------------------------------------------------
	s(
		"arch",
		fmt(
			[[
architecture {} of {} is
begin
{}
end architecture {};
]],
			{
				f(get_architecture_name, {}),
				f(filebase, {}),
				i(0),
				f(get_architecture_name, {}),
			}
		)
	),
	---------------------------------------------------------------------------
	s("ty", fmt("type {} is ({});{}", { i(1, "name"), i(2, "enum"), i(0) })),
	---------------------------------------------------------------------------
	s(
		"tyr",
		fmt(
			[[
    type {} is record
        {}
    end record {};{}
    ]],
			{
				i(1, "name"),
				i(2),
				f(get_node, 1),
				i(0),
			}
		)
	),
	---------------------------------------------------------------------------
	s(
		"select",
		fmt(
			[[
    with {} select {} <=
        {} when {},
        {} when others; {}
    ]],
			{
				i(1, "choice"),
				i(2, "target"),
				i(3, "target value"),
				i(4, "choice value"),
				i(5, "target value"),
				i(0),
			}
		)
	),
	---------------------------------------------------------------------------
	s(
		"tya",
		fmt("type {} is array ({}) of {};{}", {
			i(1, "name"),
			i(2, "integer range <>"),
			f(type_name_to_array, 1),
			i(0),
		})
	),
	---------------------------------------------------------------------------
	s(
		"tys",
		fmt(
			[[
type {} is ({});

function "?="(L,R: {}) return std_ulogic is
begin
    if L = R then
        return '1';
    else
        return '0';
    end if;
end function;

signal state: {};
signal next_state: {};

{}
]],
			{
				i(1, "state_t"),
				i(2, ""),
				f(get_node, 1),
				f(get_node, 1),
				f(get_node, 1),
				i(0),
			}
		)
	),
	---------------------------------------------------------------------------
	s(
		"case",
		fmt(
			[[
case {} is
    when {} =>
    when others =>
end case; {}
        ]],
			{
				i(1),
				i(2),
				i(0),
			}
		)
	),

	s(
		"prc",
		fmt(
			[[
    process ({})
    begin
        if rising_edge({}) then
            {}
        end if;
    end process;
        ]],
			{
				i(1, "clk"),
				f(get_node, 1),
				i(0),
			}
		)
	),
	---------------------------------------------------------------------------
})
