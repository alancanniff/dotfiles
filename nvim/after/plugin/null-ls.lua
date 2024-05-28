local ok, null_ls = pcall(require, "null-ls")
if not ok then
    return nil
end

local helpers = require("null-ls.helpers")
local methods = require("null-ls.methods")
-- local client = require("null-ls.clients")

local FORMATTING = methods.internal.FORMATTING

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local formatting_filter = function(bufnr)
    vim.lsp.buf.format({})
end

null_ls.setup({
    -- you must define at least one source for the plugin to work
    sources = {
        null_ls.builtins.formatting.markdownlint,
        null_ls.builtins.formatting.shfmt.with({
            extra_args = { "-i", "4", "-ci", "-bn" },
        }),
        null_ls.builtins.formatting.shellharden,
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.formatting.black,
        null_ls.builtins.code_actions.shellcheck,
        null_ls.builtins.diagnostics.markdownlint,
        null_ls.builtins.diagnostics.shellcheck,
    },
    debug = true,
    -- you can reuse a shared lspconfig on_attach callback here
    on_attach = function(client, bufnr)
        if client.supports_method("textDocument/formatting") then
            vim.api.nvim_create_user_command("Format", function()
                vim.lsp.buf.format({ async = true })
            end, { force = true, bang = true })

            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            if vim.o.filetype ~= "vhdl" then
                vim.api.nvim_create_autocmd("BufWritePre", {
                    group = augroup,
                    buffer = bufnr,
                    callback = function()
                        formatting_filter(bufnr)
                    end,
                })
            end
        end
    end,
})

-- local verilog_lint = {
--     method = null_ls.methods.DIAGNOSTICS,
--     filetypes = { "systemverilog", "verilog" },
--     -- null_ls.generator creates an async source
--     -- that spawns the command with the given arguments and options
--     generator = null_ls.generator({
--         command = "verible-verilog-lint",
--         args = {
--             "--rules_config_search",
--             -- "$FILENAME",
--             "-",
--         },
--         to_stdin = true,
--         from_stderr = true,
--         -- choose an output format (raw, json, or line)
--         format = "line",
--         -- use helpers to parse the output from string matchers,
--         -- or parse it manually with a function
--         on_output = helpers.diagnostics.from_patterns({
--             {
--                 pattern = [[-:(%d+):(%d+): (.*)]],
--                 groups = { "row", "col", "message" },
--             },
--             {
--                 pattern = [[%w+:(%d+):(%d+): (.*)]],
--                 groups = { "row", "col", "message" },
--             },
--         }),
--     }),
-- }
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

local vhdl_style_guide = helpers.make_builtin({
    name = "vhdl style guide",
    method = FORMATTING,
    filetypes = { "vhdl", "vhd" },
    generator_opts = {
        command = "vsg",
        args = {
            "-c",
            "/home/alan/Projects/playpen/vsg_style/personal.yaml",
            "-f",
            "$FILENAME",
            "--fix",
        },
        to_temp_file = true,
    },
    factory = helpers.formatter_factory,
})

local vsg = {
    name = "vhdl style guide",
    method = null_ls.methods.DIAGNOSTICS,
    filetypes = { "vhdl", "vhd" },
    -- null_ls.generator creates an async source
    -- that spawns the command with the given arguments and options
    generator = null_ls.generator({
        command = "vsg",
        args = {
            "-ap",
            "-c",
            vim.env.XDG_CONFIG_HOME .. "/vsg/personal.yaml",
            "-lr",
            vim.env.XDG_CONFIG_HOME .. "/vsg/rules",
            "-of",
            "syntastic",
            "-f",
            "$FILENAME",
        },
        to_stdin = false,
        from_stderr = true,
        -- choose an output format (raw, json, or line)
        format = "line",
        -- use helpers to parse the output from string matchers,
        -- or parse it manually with a function

        -- ERROR: video_lpf.vhd(139)process_018 -- Add a label for the "end process".
        on_output = helpers.diagnostics.from_patterns({
            {
                pattern = [[(%u+):%s+[%a/-_%.]+%((%d+)%)([%a_%d]+)%s+--%s+(.*)]],
                groups = { "severity", "row", "code", "message" },
            },
        }),
    }),
}

null_ls.register(vhdl_style_guide)
-- null_ls.register(vsg)
-- null_ls.register(verilog_lint)
-- null_ls.register(verilog_format)
