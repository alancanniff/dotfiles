-- LSP settings

local ok, mason = pcall(require, "mason")
if not ok then
	return nil
end

mason.setup()

local mason_lspconfig

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
ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if ok then
	mason_lspconfig.setup({
		automatic_installation = true, -- automatically detect which servers to install (based on which servers are set up via lspconfig)
	})
else
	return
end

mason_lspconfig.setup()

local ok, nvim_lsp = pcall(require, "lspconfig")
if not ok then
	return
end

local capabilities = nil

local _
ok, _ = pcall(require, "cmp")
if ok then
	-- Setup lspconfig.
	local capabilities =
		require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
end

local configs = require("lspconfig.configs")
local util = require("lspconfig.util")
-- local server_name = "vhdl_ls"

-- configs[server_name] = {
-- 	default_config = {
-- 		cmd = { "vhdl_ls" },
-- 		filetypes = { "vhdl", "vhd" },
-- 		root_dir = util.root_pattern("vhdl_ls.toml"),
-- 		docs = {
-- 			description = [[
--             https://github.com/kraigher/rust_hdl

--             language server for vhdl

--             ]],
-- 			default_config = {
-- 				root_dir = [[util.root_pattern("vhdl_ls.toml");]],
-- 			},
-- 		},
-- 	},
-- }

local ghdl_ls = "ghdl_ls"

configs[ghdl_ls] = {
	default_config = {
		cmd = { "ghdl-ls", "--log-file", vim.fn.stdpath("cache") .. "/ghdl-ls.log" },
		filetypes = { "vhdl", "vhd" },
		root_dir = util.root_pattern("hdl-prj.json"),
	},
}

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
	local function buf_set_keymap(...)
		vim.api.nvim_buf_set_keymap(bufnr, ...)
	end

	local function buf_set_option(...)
		vim.api.nvim_buf_set_option(bufnr, ...)
	end

	-- Enable completion triggered by <c-x><c-o>
	buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

	-- Mappings.
	local opts = { noremap = true, silent = true }

	-- See `:help vim.lsp.*` for documentation on any of the below functions
	buf_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
	buf_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
	buf_set_keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
	buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
	buf_set_keymap("n", "<C-s>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
	buf_set_keymap("n", "<space>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
	buf_set_keymap("n", "<space>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
	buf_set_keymap(
		"n",
		"<space>wl",
		"<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>",
		opts
	)
	buf_set_keymap("n", "<space>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
	buf_set_keymap("n", "<space>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
	buf_set_keymap("n", "<space>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
	buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
	-- buf_set_keymap("n", "<space>e", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
	-- buf_set_keymap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
	-- buf_set_keymap("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
	-- buf_set_keymap("n", "<space>q", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
	-- buf_set_keymap("n", "\f", "<cmd>lua vim.lsp.buf.formatting_sync()<CR>", opts)

	if client.supports_method("textDocument/formatting") then
		vim.api.nvim_create_user_command("Format", function()
			vim.lsp.buf.format({ async = true })
		end, { force = true, bang = true })
		-- vim.cmd([[command! -buffer Format execute 'lua vim.lsp.buf.format()' ]])
		-- vim.cmd([[
		-- augroup LspFormatting
		-- autocmd! * <buffer>
		-- autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()
		-- augroup END
		-- ]])
	end
end

-- local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
local servers = { "clangd", "ghdl_ls", "pylsp", "groovyls" }

for _, lsp in ipairs(servers) do
	nvim_lsp[lsp].setup({
		on_attach = on_attach,
		capabilities = capabilities,
		flags = {
			debounce_text_changes = 150,
		},
	})
end

local flagfile_path = os.getenv("XDG_CONFIG_HOME") .. "/verible/.rules.verible_format"

nvim_lsp["verible"].setup({
	on_attach = on_attach,
	capabilities = capabilities,
	cmd = { "verible-verilog-ls", "--rules_config_search", "--flagfile", flagfile_path },
	flags = {
		debounce_text_changes = 150,
	},
})

local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

nvim_lsp["lua_ls"].setup({
	on_attach = on_attach,
	capabilities = capabilities,
	flags = {
		debounce_text_changes = 150,
	},
	settings = {
		Lua = {
			runtime = {
				-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
				version = "LuaJIT",
				-- Setup your lua path
				path = runtime_path,
			},
			diagnostics = {
				-- Get the language server to recognize the `vim` global
				globals = { "vim" },
			},
			workspace = {
				-- Make the server aware of Neovim runtime files
				library = vim.api.nvim_get_runtime_file("", true),
			},
			-- Do not send telemetry data containing a randomized but unique identifier
			telemetry = {
				enable = false,
			},
		},
	},
})

vim.diagnostic.config({
	virtual_text = false,
})
-- Show line diagnostics automatically in hover window
vim.o.updatetime = 250
vim.cmd([[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]])
-- " command! Format lua vim.lsp.buf.formatting()<CR>
-- " nnoremap <silent> \f    :Format<CR>
