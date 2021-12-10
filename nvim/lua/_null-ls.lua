local null_ls = require("null-ls")
local helpers = require("null-ls.helpers")

require("null-ls").config({
    -- you must define at least one source for the plugin to work
    sources = { 
        null_ls.builtins.formatting.shfmt,
        null_ls.builtins.code_actions.shellcheck,
        null_ls.builtins.diagnostics.shellcheck,
    }
})

local verilog_lint = {
    method = null_ls.methods.DIAGNOSTICS,
    filetypes = { "systemverilog", "verilog" },
    -- null_ls.generator creates an async source
    -- that spawns the command with the given arguments and options
    generator = null_ls.generator({
        command = "verible-verilog-lint",
        args = { "-" },
        to_stdin = true,
        from_stderr = true,
        -- choose an output format (raw, json, or line)
        format = "line",
        check_exit_code = function(code)
            return code <= 1
        end,
        -- use helpers to parse the output from string matchers,
        -- or parse it manually with a function
        on_output = helpers.diagnostics.from_patterns({
            {
                pattern = [[-:(%d+):(%d+): (.*)]],
                groups = { "row", "col", "message" },
            },
        }),
    }),
}

null_ls.register(verilog_lint)

require("lspconfig")["null-ls"].setup({
    on_attach = function()
        vim.cmd([[ command! Format execute 'lua vim.lsp.buf.formatting()' ]])
    end,
})



-- local FORMATTING = methods.internal.FORMATTING

-- local verilog_format = helpers.make_builtin({
--     method = FORMATTING,
--     filetypes = { "systemverilog", "verilog" },
--     generator_opts = {
--         command = "verible-verilog-lint",
--         args = {
--             "-",
--         },
--         to_stdin = true,
--     },
--     factory = helpers.formatter_factory,
-- })
-- null_ls.register(verilog_format)
--

-- local verilog_format = {
--     method = null_ls.methods.FORMATTING,
--     filetypes = { "systemverilog", "verilog" },
--     -- null_ls.generator creates an async source
--     -- that spawns the command with the given arguments and options
--     generator = null_ls.generator({
--         command = "verible-verilog-format",
--         args = { "-" },
--         to_stdin = true,
--         check_exit_code = function(code)
--             return code <= 1
--         end,
--     }),
-- }
