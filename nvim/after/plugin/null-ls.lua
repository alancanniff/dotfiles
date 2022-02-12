local ok, null_ls = pcall(require, "null-ls")
if not ok then
	return nil
end

local helpers = require("null-ls.helpers")
local methods = require("null-ls.methods")

local FORMATTING = methods.internal.FORMATTING

null_ls.setup({
	-- you must define at least one source for the plugin to work
	sources = {
		null_ls.builtins.formatting.markdownlint,
		null_ls.builtins.formatting.shfmt.with({
			extra_args = { "-i", "4", "-ci", "-bn" },
		}),
		null_ls.builtins.formatting.shellharden,
		null_ls.builtins.formatting.stylua,

		null_ls.builtins.code_actions.shellcheck,

		null_ls.builtins.diagnostics.markdownlint,
		null_ls.builtins.diagnostics.shellcheck,
		-- null_ls.builtins.diagnostics.cspell,
	},

	debug = true,

	on_attach = function(client)
		if client.resolved_capabilities.document_formatting then
			vim.cmd([[command! Format execute 'lua vim.lsp.buf.formatting()' ]])
			vim.cmd([[
            augroup LspFormatting
                autocmd! * <buffer>
                autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()
            augroup END
            ]])
		end
	end,
})

local verilog_format = helpers.make_builtin({
	method = FORMATTING,
	filetypes = { "systemverilog", "verilog" },
	generator_opts = {
		command = "verible-verilog-format",
		args = {
			"--assignment_statement_alignment=flush-left",
			"--case_items_alignment=flush-left",
			"--class_member_variable_alignment=flush-left",
			"--distribution_items_alignment=flush-left",
			"--enum_assignment_statement_alignment=flush-left",
			"--formal_parameters_alignment=flush-left",
			"--module_net_variable_alignment=flush-left",
			"--named_parameter_alignment=flush-left",
			"--named_port_alignment=flush-left",
			"--port_declarations_alignment=flush-left",
			"--struct_union_members_alignment=flush-left",
			"--indentation_spaces=4",
			"-",
		},
		to_stdin = true,
	},
	factory = helpers.formatter_factory,
})

local verilog_lint = {
	method = null_ls.methods.DIAGNOSTICS,
	filetypes = { "systemverilog", "verilog" },
	-- null_ls.generator creates an async source
	-- that spawns the command with the given arguments and options
	generator = null_ls.generator({
		command = "verible-verilog-lint",
		args = {
			"--rules_config_search",
			-- "$FILENAME",
			"-",
		},
		to_stdin = true,
		from_stderr = true,
		-- choose an output format (raw, json, or line)
		format = "line",
		-- use helpers to parse the output from string matchers,
		-- or parse it manually with a function
		on_output = helpers.diagnostics.from_patterns({
			{
				pattern = [[-:(%d+):(%d+): (.*)]],
				groups = { "row", "col", "message" },
			},
			{
				pattern = [[%w+:(%d+):(%d+): (.*)]],
				groups = { "row", "col", "message" },
			},
		}),
	}),
}

-- null_ls.register(verilog_lint)
-- null_ls.register(verilog_format)
