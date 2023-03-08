local ok, mason = pcall(require, "mason")
if not ok then
	return nil
end

mason.setup()

local mason_lspconfig

ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if not ok then
	return nil
end

mason_lspconfig.setup()

-- require("mason-lspconfig").setup_handlers {
--     -- The first entry (without a key) will be the default handler
--     -- and will be called for each installed server that doesn't have
--     -- a dedicated handler.
--     function (server_name) -- default handler (optional)
--         require("lspconfig")[server_name].setup {}
--     end,
--     -- Next, you can provide a dedicated handler for specific servers.
--     -- For example, a handler override for the `rust_analyzer`:
--     ["rust_analyzer"] = function ()
--         require("rust-tools").setup {}
--     end
-- }
