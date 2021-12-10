local null_ls = require("null-ls")

require("null-ls").config({
    -- you must define at least one source for the plugin to work
    sources = { 
        null_ls.builtins.formatting.shfmt,
        null_ls.builtins.code_actions.shellcheck,
        null_ls.builtins.diagnostics.shellcheck,
    }
})

require("lspconfig")["null-ls"].setup({
    on_attach = function()
        vim.cmd([[ command! Format execute 'lua vim.lsp.buf.formatting()' ]])
    end,
})



