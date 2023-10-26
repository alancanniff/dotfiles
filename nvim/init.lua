-- require("impatient")
-- require("impatient").enable_profile()

-- Windows settings {{{
local is_windows = vim.fn.has("win32") or vim.fn.has("win64")
vim.api.nvim_set_var("is_windows", is_windows)

if is_windows == 1 then
	vim.api.nvim_set_var("python3_host_prog", "c:/Windows/py.exe")
end
-- }}}

-- Package {{{
local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
	vim.fn.execute("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
end

local packer_group = vim.api.nvim_create_augroup("Packer", { clear = true })
vim.api.nvim_create_autocmd(
	"BufWritePost",
	{ command = "source <afile> | PackerCompile", group = packer_group, pattern = "init.lua" }
)

require("packer").startup(function(use)
	-- Packer can manage itself

	use({ "fidian/hexmode" })

	use({
		"hrsh7th/nvim-cmp",
		requires = {
			"hrsh7th/cmp-nvim-lsp",
			"neovim/nvim-lspconfig",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
			-- "hrsh7th/cmp-cmdline",
		},
	})

	use({
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		require = { "neovim/nvim-lspconfig" },
	})

	use({ "junegunn/fzf" })
	use({ "junegunn/fzf.vim" })
	use({ "justinmk/vim-dirvish" })

	if vim.fn.executable("ctags") == 1 then
		use({ "ludovicchabant/vim-gutentags" })
	end

	use({ "machakann/vim-sandwich" })

	use({
		"jose-elias-alvarez/null-ls.nvim",
		requires = {
			"neovim/nvim-lspconfig",
			"nvim-lua/plenary.nvim",
		},
	})

	use({
		"L3MON4D3/LuaSnip",
		requires = { "honza/vim-snippets" },
	})

	use({ "michaeljsmith/vim-indent-object" })
	use({ "neovim/nvim-lspconfig" })
	use({ "nvim-lua/plenary.nvim" })
	use({ "nvim-lua/telescope.nvim" })
	use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })
	use({
		"nvim-treesitter/nvim-treesitter",
		requires = {
			"nvim-treesitter/nvim-treesitter-textobjects",
			"nvim-treesitter/playground",
		},
		run = ":TSUpdate",
	})

	use({
		"nvim-lualine/lualine.nvim",
		requires = { "kyazdani42/nvim-web-devicons", opt = true },
	})
	use({ "rafcamlet/nvim-luapad" })
	use({ "rktjmp/lush.nvim" })
	use({ "sbulav/nredir.nvim", opt = true })
	use({ "simnalamburt/vim-mundo" })

	use({
		"skywind3000/asynctasks.vim",
		requires = { "skywind3000/asyncrun.vim" },
	})
	use({ "ThePrimeagen/git-worktree.nvim" })
	use({ "tommcdo/vim-lion" })
	use({ "tpope/vim-eunuch" })
	use({
		"tpope/vim-fugitive",
		requires = { "shumphrey/fugitive-gitlab.vim" },
	})
	use({ "tpope/vim-repeat" })
	use({ "tpope/vim-commentary" })
	use({ "vim-scripts/DoxygenToolkit.vim" })
	use({ "wbthomason/packer.nvim" })

	use({ "alancanniff/twotone" })
end)

--- }}}

-- Options {{{

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

-- set listchars=tab:▸\ ,trail:·,extends:>,precedes:<,nbsp:+
vim.o.list = true
vim.opt.listchars = vim.opt.listchars + { tab = "▸ ", trail = "·" }

vim.o.timeoutlen = 3000
vim.o.lazyredraw = true

-- disable some of the built in plugins
-- vim.g.loaded_netrwPlugin = 1
-- vim.g.loaded_netrw = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_tar = 1
vim.g.loaded_zipPlugin = 1
vim.g.loaded_zip = 1

-- }}}

-- Commands  {{{

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

vim.api.nvim_create_user_command("Testing", function(opts)
	local gitlab = require("gitlab")
	gitlab.report_jobs()
end, { force = true, nargs = 0, bang = true })

vim.api.nvim_create_user_command("Testing", function(opts)
	-- local Terminal = require("toggleterm.terminal").Terminal
	-- local lazygit = Terminal:new({ cmd = "lazygit", hidden = true })
end, { force = true, nargs = 0, bang = true })
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

-- Diagnostic keymaps
vim.keymap.set("n", "S", ":%s/<C-r><C-w>//g<left><left>")

-- Diagnostic keymaps
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist)

vim.keymap.set("n", "[q", ":cprevious<Cr>")
vim.keymap.set("n", "]q", ":cnext<Cr>")
vim.keymap.set("n", "[Q", ":cfirst<Cr>")
vim.keymap.set("n", "]Q", ":clast<Cr>")

vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], { desc = "Enable Esc in terminal mode" })
vim.keymap.set("t", "<C-w>", [[<C-\><C-n><C-w>]], { desc = "Enable <C-w> in terminal mode" })
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

vim.api.nvim_create_autocmd("ColorScheme", {
	group = general_group,
	pattern = "monotone",
	callback = function()
		vim.fn["my_utils#Monotone_Mods"]()
	end,
	desc = "Apply custom mods to monotone colorscheme",
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

vim.api.nvim_create_autocmd("BufEnter", {
	group = general_group,
	pattern = "*",
	callback = function()
		return
		-- local line = vim.fn.line
		-- if (vim.o.filetype ~= "gitcommit") and (line("'\"") > 0) and (line("'\"") <= line("$")) then
		-- 	vim.cmd([[execute 'normal! g`"zvzz']])
		-- end
	end,
	desc = "Go to the last position in the file ",
})

-- vim.api.nvim_create_autocmd("FileChangedShellPost", {
-- 	group = general_group,
-- 	pattern = "*",
-- 	callback = function()
-- 		print("File changed on disk. Buffer reloaded.")
-- 	end,
-- 	desc = "Warn that a file has been reloaded",
-- })

-- Highlight on yank
-- local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })

-- vim.api.nvim_create_autocmd("TextYankPost", {
-- 	callback = function()
-- 		vim.highlight.on_yank()
-- 	end,
-- 	group = highlight_group,
-- 	pattern = "*",
-- 	desc = "Highlight yanked text",
-- })

-- }}}

-- {{{

vim.cmd([[colorscheme twotone]])
-- Update lualine after the colorscheme to fix the highlighting
require("lualine").setup()

-- }}}
