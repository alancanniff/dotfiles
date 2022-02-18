-- TM_SELECTED_TEXT The currently selected text or the empty string
-- TM_CURRENT_LINE The contents of the current line
-- TM_CURRENT_WORD The contents of the word under cursor or the empty string
-- TM_LINE_INDEX The zero-index based line number
-- TM_LINE_NUMBER The one-index based line number
-- TM_FILENAME The filename of the current document
-- TM_FILENAME_BASE The filename of the current document without its extensions
-- TM_DIRECTORY The directory of the current document
-- TM_FILEPATH The full file path of the current document
-- https://github.com/microsoft/language-server-protocol/blob/main/snippetSyntax.md
--
-- # Choices
-- ${1|one,two,three|}
--
-- # Variables
-- With $name or ${name:default}, you can insert the value of a variable. When a variable isn't set, its default or the empty string is inserted. When a variable is unknown (that is, its name isn't defined) the name of the variable is inserted and it is transformed into a placeholder.
--
-- # Replacements
--
-- // in file 'Code/User/snippets/javascript.json'

local ok, ls = pcall(require, "luasnip")
if not ok then
	return nil
end

ls.snippets = {
	all = {
		ls.parser.parse_snippet("Alan", "$1 is ${2|hard,easy,challenging|}"),
		ls.parser.parse_snippet("proc", "proc $1 {$2} {\n\t$0\n}"),
	},
	tcl = {
		ls.parser.parse_snippet("dbg", [[puts "Debug: $1"$0]]),
    },
	systemverilog = {
		ls.parser.parse_snippet(
			"mod",
			[[/**
 *  $3
 */
module $1 #($2
)($4
);$0
endmodule]]
		),
	},
}
