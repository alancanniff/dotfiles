-- LSP settings
local ok, nvim_lsp = pcall(require, "lspconfig")
if not ok then
	return
end

local capabilities = nil

local ok, cmp = pcall(require, "cmp")
if ok then
	-- Setup lspconfig.
	local capabilities = require("cmp_nvim_lsp").update_capabilities(
		vim.lsp.protocol.make_client_capabilities()
	)
end

local configs = require("lspconfig.configs")
local util = require("lspconfig.util")
local server_name = "vhdl_ls"

configs[server_name] = {
	default_config = {
		cmd = { "vhdl_ls" },
		filetypes = { "vhdl", "vhd" },
		root_dir = util.root_pattern("vhdl_ls.toml"),
		docs = {
			description = [[
            https://github.com/kraigher/rust_hdl

            language server for vhdl

            ]],
			default_config = {
				root_dir = [[util.root_pattern("vhdl_ls.toml");]],
			},
		},
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

	-- print(client.name)

	if client.resolved_capabilities.document_formatting then
		vim.cmd([[command! -buffer Format execute 'lua vim.lsp.buf.formatting()' ]])
		-- vim.cmd([[
		-- augroup LspFormatting
		-- autocmd! * <buffer>
		-- autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()
		-- augroup END
		-- ]])
	end
end

-- local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
local servers = { "clangd", "vhdl_ls", "pylsp" }

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

nvim_lsp["sumneko_lua"].setup({
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
