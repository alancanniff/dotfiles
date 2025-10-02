-- Options {{{

local is_windows = vim.fn.has("win32") or vim.fn.has("win64")
vim.api.nvim_set_var("is_windows", is_windows)

if is_windows == 1 then
	vim.g.python3_host_prog = "c:/Windows/py.exe"
else
	vim.g.python3_host_prog = vim.fn.stdpath("config") .. "/venv/bin/python"
end

vim.o.shortmess = "caAOstT"
vim.o.cursorline = true
vim.o.cursorcolumn = true

vim.o.foldmarker = "{{{,}}}"
vim.o.foldmethod = "marker"
vim.o.foldnestmax = 1

vim.o.showmode = false -- Don't show the mode in the command line

vim.o.backup = true
vim.opt.backupdir = vim.opt.backupdir - "."

vim.o.wrap = false
vim.o.pumheight = 20

vim.o.cmdheight = 2
vim.o.confirm = true
vim.o.showmatch = true
vim.o.wildmode = "longest:full,list:full"
vim.o.title = true

vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true

vim.o.virtualedit = "all"
vim.o.history = 10000
vim.o.scrolloff = 3
vim.o.sidescrolloff = 5
vim.o.sidescroll = 5
vim.o.visualbell = true
vim.o.infercase = false

--Set highlight on search
vim.o.hlsearch = true

--Make line numbers default
vim.wo.number = true

--Enable mouse mode
vim.o.mouse = "nv"

--Enable break indent
vim.o.breakindent = true

--Save undo history
vim.opt.undofile = true

--Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

--Decrease update time
vim.o.updatetime = 250
vim.wo.signcolumn = "yes"

--Set colorscheme
vim.o.termguicolors = true

-- Set completeopt to have a better completion experience
vim.o.completeopt = "menuone,noselect"

-- Limit the height of the pumenu
vim.opt.pumheight = 10

-- set listchars=tab:▸\ ,trail:·,extends:>,precedes:<,nbsp:+
vim.o.list = true
vim.opt.listchars = vim.opt.listchars + { tab = "▸ ", trail = "·" }
-- vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

vim.o.timeoutlen = 300
vim.o.lazyredraw = true

-- disable some of the built in plugins
-- vim.g.loaded_netrwPlugin = 1
-- vim.g.loaded_netrw = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_tar = 1
vim.g.loaded_zipPlugin = 1
vim.g.loaded_zip = 1
vim.g.loaded_perl_provider = 0
vim.g.loaded_node_provider = 0
vim.g.loaded_ruby_provider = 0
-- 	- "none": No border.
-- - "single": A single line box.
-- - "double": A double line box.
-- - "rounded": Like "single", but with rounded corners ("╭" etc.).
-- - "solid": Adds padding by a single whitespace cell.
-- - "shadow": A drop shadow effect by blending with the background.
-- vim.o.winborder = "single"

vim.diagnostic.config({
	virtual_text = false,
	virtual_lines = false,
	signs = true,
	underline = true,
	update_in_insert = false,
	severity_sort = false,
})
-- }}}

-- Commands  {{{

-- local DiagnosticToggleState = false
vim.api.nvim_create_user_command("DiagnosticToggle", function()
	local current = vim.diagnostic.config().virtual_lines
	local config
	if not current then
		config = { current_line = true }
	else
		config = false
	end

	vim.diagnostic.config({ virtual_lines = config })
end, { force = true, desc = "Toggle the diagnostic 'virtual_lines'" })

vim.api.nvim_create_user_command("GetHighlightGroups", function()
	local synstack = vim.fn.synstack(vim.fn.line("."), vim.fn.col("."))
	local result = {}
	for _, syn in ipairs(synstack) do
		table.insert(result, vim.fn.synIDattr(syn, "name"))
	end
	print(vim.inspect(result))
end, { force = true, desc = "Print the highlight groupd under the cursor" })

-- nnoremap  \cd :cd %:p:h<CR>|:pwd
vim.api.nvim_create_user_command(
	"Cd",
	"cd %:p:h",
	{ force = true, desc = "cd to the directory of the current file" }
)

-- taken from "sbulav/nredir.nvim"
vim.api.nvim_create_user_command("Redir", function(opts)
	local function removeAscii(text)
		for k, v in pairs(text) do
			-- Remove all the ansi escape characters
			text[k] = string.gsub(v, "[\27\155][][()#;?%d]*[A-PRZcf-ntqry=><~]", "")
		end
		return text
	end

	local function starts_with(str, start)
		return str:sub(1, #start) == start
	end

	local cmd = opts.args
	local result = {}

	if cmd == nil or cmd == "" then
		table.insert(result, "Attempt to execute empty command!")
	elseif starts_with(cmd, "!") then
		-- System command
		result = removeAscii(vim.fn.systemlist(string.sub(cmd, 2)))
	else
		-- Vim EX command
		result = vim.fn.split(vim.fn.execute(cmd), "\n")
	end

	vim.api.nvim_command("botright vnew")
	local buf = vim.api.nvim_get_current_buf()

	vim.api.nvim_buf_set_name(0, "Redir '" .. cmd .. "'")

	vim.opt_local.buftype = "nofile"
	vim.opt_local.swapfile = false
	vim.opt_local.bufhidden = "wipe"
	vim.api.nvim_buf_set_lines(buf, 0, -1, false, result)
end, { force = true, nargs = 1, complete = "command", desc = "Redirect cmd output to buffer" })

-- vim.api.nvim_create_user_command("Testing", function(opts)
-- 	local gitlab = require("gitlab")
-- 	gitlab.report_jobs()
-- end, { force = true, nargs = 0, bang = true })

-- vim.api.nvim_create_user_command("Testing", function(opts)
-- 	-- local Terminal = require("toggleterm.terminal").Terminal
-- 	-- local lazygit = Terminal:new({ cmd = "lazygit", hidden = true })
-- end, { force = true, nargs = 0, bang = true })
-- }}}

-- Keymaps {{{

vim.keymap.set("n", "<Space>o", "moo<Esc>`o", { desc = "Add line below without moving cursor" })
vim.keymap.set("n", "<Space>O", "moO<Esc>`o", { desc = "Add line above without moving cursor" })

vim.keymap.set("n", "\\/", function()
	local line = vim.fn.getline(".")
	line = vim.fn.substitute(line, "\\", "/", "g")
	vim.fn.setline(".", line)
end, { silent = true, desc = "Swap \\ with /" })

vim.keymap.set("n", "\\\\", function()
	local line = vim.fn.getline(".")
	line = vim.fn.substitute(line, "/", "\\", "g")
	vim.fn.setline(".", line)
end, { silent = true, desc = "Swap / with \\" })

-- Make the mouse behave the way that I want
vim.keymap.set("n", "<RightDrag>", "<Nop>")
vim.keymap.set("n", "<RightRelease>", "<MiddleRelease>")
vim.keymap.set("n", "<RightMouse>", "<MiddleMouse>")

vim.keymap.set("i", "<RightDrag>", "<Nop>")
vim.keymap.set("i", "<RightRelease>", "<MiddleRelease>")
vim.keymap.set("i", "<RightMouse>", "<MiddleMouse>")

vim.keymap.set({ "n", "i", "x", "c", "t" }, "<LeftRelease>", '"+y')

vim.keymap.set("n", "'", "`", { desc = "Make ' go to exact postition" })
vim.keymap.set("n", "`", "'", { desc = "make ` go to begining of line" })

--Remap for dealing with word wrap
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

vim.keymap.set("n", "S", ":%s/<C-r><C-w>//g<left><left>", { desc = "Substitute word under cursor" })

vim.keymap.set(
	"n",
	"<leader>e",
	vim.diagnostic.open_float,
	{ desc = "Show diagnostic [E]rror messages" }
)
vim.keymap.set(
	"n",
	"<leader>q",
	vim.diagnostic.setloclist,
	{ desc = "Open diagnostic [Q]uickfix list" }
)

vim.keymap.set(
	"n",
	"<C-]>",
	"g<C-]>",
	{ desc = "jump to the tag directly when there is only one match" }
)

vim.keymap.set("c", "<C-p>", function()
	return vim.fn.wildmenumode == 1 and "<C-p>" or "<Up>"
end, { expr = true })

vim.keymap.set("c", "<C-n>", function()
	return vim.fn.wildmenumode == 1 and "<C-n>" or "<Down>"
end, { expr = true })
-- }}}

-- {{{ My Autocmds

local general_group = vim.api.nvim_create_augroup("general", { clear = true })

vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
	group = general_group,
	pattern = "Jenkinsfile*",
	callback = function()
		vim.opt.filetype = "groovy"
	end,
	desc = "Set line number and disable cursorline / column",
})

vim.api.nvim_create_autocmd("FileType", {
	group = general_group,
	pattern = "netrw",
	callback = function()
		vim.opt_local.bufhidden = "delete"
	end,
	desc = "Delete hidden netrw buffers",
})

vim.api.nvim_create_autocmd("FileType", {
	group = general_group,
	pattern = "*",
	callback = function()
		vim.opt.formatoptions = vim.opt.formatoptions + { "j", "c" }
		vim.opt.formatoptions = vim.opt.formatoptions - { "r", "o" }
	end,
	desc = "Set some global formatting options",
})

vim.api.nvim_create_autocmd("BufEnter", {
	group = general_group,
	pattern = "*",
	callback = function()
		if vim.o.filetype ~= "help" then
			vim.opt.cursorcolumn = true
			vim.opt.cursorline = true
			vim.opt.number = true
		end
	end,
	desc = "Set line number and disable cursorline / column",
})

vim.api.nvim_create_autocmd("BufLeave", {
	group = general_group,
	pattern = "*",
	callback = function()
		if vim.o.filetype ~= "help" then
			vim.opt.cursorcolumn = false
			vim.opt.cursorline = false
			vim.opt.relativenumber = false
			vim.opt.number = true
		end
	end,
	desc = "Set line number and disable cursorline / column",
})

vim.api.nvim_create_autocmd("TermEnter", {
	group = general_group,
	pattern = "*",
	callback = function()
		if vim.o.filetype ~= "fzf" then
			vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { buffer = true })
			-- vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], { desc = "Enable Esc in terminal mode" })
			vim.keymap.set("t", "<C-w>", [[<C-\><C-n><C-w>]], { buffer = true })
		end
	end,
	desc = "Set esc in the terminal window",
})

-- }}}

-- Package {{{

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	{
		"alancanniff/twotone",
		-- Make sure to load this before all the other start plugins.
		priority = 1000,
		dependencies = {
			"rktjmp/lush.nvim",
		},
		init = function()
			vim.cmd.colorscheme("twotone")
		end,
	},

	"fidian/hexmode",

	{ -- Fuzzy Finder (files, lsp, etc)
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
				cond = function()
					return vim.fn.executable("make") == 1
				end,
			},
			{ "nvim-telescope/telescope-ui-select.nvim" },
			{ "nvim-treesitter/nvim-treesitter" },
		},
	},

	{
		-- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
		-- used for completion, annotations and signatures of Neovim apis
		"folke/lazydev.nvim",
		ft = "lua",
		opts = {
			library = {
				-- Load luvit types when the `vim.uv` word is found
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
			},
		},
	},
	{ -- LSP Configuration & Plugins
		"neovim/nvim-lspconfig",
		dependencies = {
			-- Automatically install LSPs and related tools to stdpath for Neovim
			{ "williamboman/mason.nvim", config = true }, -- NOTE: Must be loaded before dependants
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			"nvim-telescope/telescope.nvim",
		},
		config = function()
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			-- capabilities = vim.tbl_deep_extend(
			-- 	"force",
			-- 	capabilities,
			-- 	require("cmp_nvim_lsp").default_capabilities()
			-- )

			-- require("lspconfig.configs").ghdl_ls = {
			-- 	default_config = {
			-- 		cmd = { "ghdl-ls", "--log-file", vim.fn.stdpath("cache") .. "/ghdl-ls.log" },
			-- 		filetypes = { "vhdl", "vhd" },
			-- 		root_dir = require("lspconfig.util").root_pattern("hdl-prj.json"),
			-- 	},
			-- }
			-- Enable the following language servers
			--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
			--
			--  Add any additional override configuration in the following tables. Available keys are:
			--  - cmd (table): Override the default command used to start the server
			--  - filetypes (table): Override the default list of associated filetypes for the server
			--  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
			--  - settings (table): Override the default settings passed when initializing the server.
			--        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
			local servers = {
				-- pyright = {},
				-- rust_hdl = {},
				-- lua_ls = {
				-- 	-- cmd = {...},
				-- 	-- filetypes = { ...},
				-- 	-- capabilities = {},
				-- 	settings = {
				-- 		Lua = {
				-- 			completion = {
				-- 				callSnippet = "Replace",
				-- 			},
				-- 			diagnostics = {
				-- 				-- Get the language server to recognize the `vim` global
				-- 				globals = { "vim" },
				-- 				disable = { "missing-fields" },
				-- 			},
				-- 		},
				-- 	},
				-- },
			}

			-- Ensure the servers and tools above are installed
			--  To check the current status of installed tools and/or manually install
			--  other tools, you can run
			--    :Mason
			--
			--  You can press `g?` for help in this menu.
			require("mason").setup()

			-- You can add other tools here that you want Mason to install
			-- for you, so that they are available from within Neovim.
			local ensure_installed = vim.tbl_keys(servers or {})
			vim.list_extend(ensure_installed, {
				"stylua",
				"shellcheck",
				"shfmt",
				"shellharden",
				"markdownlint",
				"black",
			})
			-- require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

			require("mason-lspconfig").setup({
				handlers = {
					function(server_name)
						local server = servers[server_name] or {}
						-- This handles overriding only values explicitly passed
						-- by the server configuration above. Useful when disabling
						-- certain features of an LSP (for example, turning off formatting for tsserver)
						server.capabilities = vim.tbl_deep_extend(
							"force",
							{},
							capabilities,
							server.capabilities or {}
						)
						require("lspconfig")[server_name].setup(server)
					end,
				},
			})
		end,
	},

	{
		"junegunn/fzf.vim",
		dependencies = {

			"junegunn/fzf",
		},
	},

	"justinmk/vim-dirvish",

	{
		"ludovicchabant/vim-gutentags",
		enabled = function()
			return vim.fn.executable("ctags") == 1
		end,
	},

	{ -- Adds git related signs to the gutter, as well as utilities for managing changes
		"lewis6991/gitsigns.nvim",
		opts = {
			signs = {
				add = { text = "+" },
				change = { text = "~" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
			},
		},
	},

	"machakann/vim-sandwich",

	{
		"L3MON4D3/LuaSnip",
		dependencies = { "honza/vim-snippets" },
	},

	"michaeljsmith/vim-indent-object",

	{ -- Highlight, edit, and navigate code
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		main = "nvim-treesitter.configs", -- Sets main module to use for opts
		-- [[ Configure Treesitter ]] See `:help nvim-treesitter`
		opts = {
			ensure_installed = {
				"bash",
				"c",
				"diff",
				"html",
				"lua",
				"luadoc",
				"markdown",
				"markdown_inline",
				"query",
				"vim",
				"vimdoc",
			},
			-- Autoinstall languages that are not installed
			auto_install = true,
			highlight = {
				enable = true,
				-- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
				--  If you are experiencing weird indenting issues, add the language to
				--  the list of additional_vim_regex_highlighting and disabled languages for indent.
				-- disable = { "vhdl" },
				additional_vim_regex_highlighting = { "ruby" },
			},
			indent = { enable = true, disable = { "ruby" } },
		},
		-- There are additional nvim-treesitter modules that you can use to interact
		-- with nvim-treesitter. You should go explore a few and see what interests you:
		--
		--    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
		--    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
		--    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
	},

	"nvim-lualine/lualine.nvim",
	"simnalamburt/vim-mundo",

	{
		"skywind3000/asynctasks.vim",
		dependencies = { "skywind3000/asyncrun.vim" },
	},

	{ -- Autoformat
		"stevearc/conform.nvim",
		lazy = false,
		keys = {},
		opts = {
			notify_on_error = false,

			format_on_save = function(bufnr)
				if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
					return
				end
				-- Disable "format_on_save lsp_fallback" for languages that don't
				-- have a well standardized coding style. You can add additional
				-- languages here or re-enable it for the disabled ones.
				local disable_filetypes = { c = true, cpp = true }
				return {
					timeout_ms = 500,
					lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
				}
			end,
			formatters_by_ft = {
				lua = { "stylua" },
				python = { "black" },
				sh = { "shfmt", "shellharden" },
				markdown = { "markdownlint" },
				--
				-- You can use a sub-list to tell conform to run *until* a formatter
				-- is found.
				-- javascript = { { "prettierd", "prettier" } },
			},
			formatters = {
				shfmt = {
					prepend_args = { "-i", "4", "-ci", "-bn" },
				},
			},
		},
	},

	{ -- Autocompletion
		"hrsh7th/nvim-cmp",
		-- event = 'InsertEnter',
		dependencies = {
			-- Snippet Engine & its associated nvim-cmp source
			{
				"L3MON4D3/LuaSnip",
				build = (function()
					-- Build Step is needed for regex support in snippets.
					-- This step is not supported in many windows environments.
					-- Remove the below condition to re-enable on windows.
					if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
						return
					end
					return "make install_jsregexp"
				end)(),
				dependencies = {
					-- `friendly-snippets` contains a variety of premade snippets.
					--    See the README about individual language/framework/plugin snippets:
					--    https://github.com/rafamadriz/friendly-snippets
					-- {
					--   'rafamadriz/friendly-snippets',
					--   config = function()
					--     require('luasnip.loaders.from_vscode').lazy_load()
					--   end,
					-- },
				},
			},
			"saadparwaiz1/cmp_luasnip",

			-- Adds other completion capabilities.
			--  nvim-cmp does not ship with all sources by default. They are split
			--  into multiple repos for maintenance purposes.
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-buffer",
		},

		config = function()
			-- See `:help cmp`
			local cmp = require("cmp")
			local luasnip = require("luasnip")
			luasnip.config.setup({})

			cmp.setup({
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				-- completion = { completeopt = "menu,menuone,noinsert" },
				completion = { autocomplete = false, completeopt = "menuone,noselect" },

				-- For an understanding of why these mappings were
				-- chosen, you will need to read `:help ins-completion`
				--
				-- No, but seriously. Please read `:help ins-completion`, it is really good!
				mapping = cmp.mapping.preset.insert({
					["<C-n>"] = cmp.mapping.select_next_item(),
					["<C-p>"] = cmp.mapping.select_prev_item(),
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-y>"] = cmp.mapping.confirm({ select = true }),
					["<C-Space>"] = cmp.mapping.complete({}),

					-- Think of <c-l> as moving to the right of your snippet expansion.
					--  So if you have a snippet that's like:
					--  function $name($args)
					--    $body
					--  end
					--
					-- <c-l> will move you to the right of each of the expansion locations.
					-- <c-h> is similar, except moving you backwards.
					["<C-l>"] = cmp.mapping(function()
						if luasnip.expand_or_locally_jumpable() then
							luasnip.expand_or_jump()
						end
					end, { "i", "s" }),
					["<C-h>"] = cmp.mapping(function()
						if luasnip.locally_jumpable(-1) then
							luasnip.jump(-1)
						end
					end, { "i", "s" }),

					-- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
					--    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
				}),
				sources = {
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
					{
						name = "buffer",
						option = {
							get_bufnrs = function()
								return vim.api.nvim_list_bufs()
							end,
						},
					},
					{ name = "path" },
				},
			})
		end,
	},

	-- Jump to the definition of the word under your cursor.
	--  This is where a variable was first declared, or where a function is defined, etc.
	--  To jump back, press <C-t>.

	"ThePrimeagen/git-worktree.nvim",
	"tommcdo/vim-lion",
	"tpope/vim-eunuch",
	"tpope/vim-repeat",
	"tpope/vim-fugitive",
	"vim-scripts/DoxygenToolkit.vim",

	{ -- Linting
		"mfussenegger/nvim-lint",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local lint = require("lint")
			lint.linters_by_ft = {
				markdown = { "markdownlint" },
				sh = { "shellcheck" },
			}

			local shellcheck = require("lint").linters.shellcheck
			shellcheck.args = {
				"--format=json",
				"--source-path=SCRIPTDIR",
				"-x",
				"-",
			}

			-- Create autocommand which carries out the actual linting
			-- on the specified events.
			local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
			vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
				group = lint_augroup,
				callback = function()
					require("lint").try_lint()
				end,
			})
		end,
	},
	-- {
	-- 	"saghen/blink.cmp",
	-- 	version = "1.*",
	-- 	opts = {
	-- 		snippets = { preset = "luasnip" },
	-- 		-- Default list of enabled providers defined so that you can extend it
	-- 		-- elsewhere in your config, without redefining it, due to `opts_extend`
	-- 		fuzzy = {
	-- 			sorts = {
	-- 				"exact",
	-- 			},
	-- 		},
	-- 		sources = {
	-- 			default = { "buffer", "lsp", "path", "snippets" },
	-- 		},
	-- 		-- 	providers = {
	-- 		-- 		buffer = {
	-- 		-- 			opts = {
	-- 		-- 				-- or (recommended) filter to only "normal" buffers
	-- 		-- 				get_bufnrs = function()
	-- 		-- 					return vim.tbl_filter(function(bufnr)
	-- 		-- 						return vim.bo[bufnr].buftype == ""
	-- 		-- 					end, vim.api.nvim_list_bufs())
	-- 		-- 				end,
	-- 		-- 			},
	-- 		-- 		},
	-- 		-- 	},
	-- 		-- },
	--
	-- 		completion = {
	-- 			accept = { auto_brackets = { enabled = false } },
	-- 			-- ghost_text = { enabled = true },
	-- 			list = { selection = { preselect = true, auto_insert = true } },
	-- 			menu = {
	-- 				-- Don't automatically show the completion menu
	-- 				auto_show = false,
	-- 				-- nvim-cmp style menu
	-- 				draw = {
	-- 					columns = {
	-- 						{ "label", "label_description", gap = 1 },
	-- 						{ "kind_icon", "kind", gap = 1 },
	-- 					},
	-- 				},
	-- 			},
	-- 		},
	-- 		-- keymap = { preset = "default" },
	-- 		keymap = {
	-- 			-- preset = "default",
	-- 			-- set to 'none' to disable the 'default' preset
	-- 			-- show with a list of providers
	-- 			-- ['<C-space>'] = { function(cmp) cmp.show({ providers = { 'snippets' } }) end },
	-- 			-- control whether the next command will be run when using a function
	-- 			["<C-n>"] = {
	-- 				function(cmp)
	-- 					if not cmp.visible then
	-- 						return cmp.show_and_insert()
	-- 					end
	-- 				end,
	-- 				"select_next",
	-- 				"fallback",
	-- 			},
	-- 			["<C-p>"] = {
	-- 				function(cmp)
	-- 					if not cmp.visible then
	-- 						return cmp.show_and_insert()
	-- 					end
	-- 				end,
	-- 				"select_prev",
	-- 				"fallback",
	-- 			},
	-- 			-- ["<Tab>"] = {},
	-- 			-- ["<S-Tab>"] = {},
	-- 		},
	-- 	},
	-- },
})
--- }}}
