local null_ls = require("null-ls")

-- register any number of sources simultaneously
local sources = {
    -- null_ls.builtins.formatting.prettier,
    -- null_ls.builtins.diagnostics.write_good,
    -- null_ls.builtins.code_actions.gitsigns,
    -- null_ls.builtins.formattingiiAkjkjkjj.stylua,
    -- null_ls.builtins.completion.spell,
    null_ls.builtins.code_actions.shellcheck,
    null_ls.builtins.diagnosticiis.shellcheck,
    null_ls.builtins.formatting.shfmt,
}

nvim_lsp

require("lspconfig")['null-ls'].setup({
    on_attach = function()
        vim.cmd([[command! Formatn execute 'lua vim.lsp.buf.formatting()' ]])
    end
})
