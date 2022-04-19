local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

local packer_bootstrap
if fn.empty(fn.glob(install_path)) > 0 then
	packer_bootstrap = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
end

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost _packer.lua source <afile> | PackerCompile
  augroup end
]])

return require("packer").startup(function()
	-- use { 'alexghergh/nvim-tmux-navigation'}
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

	use({ "junegunn/fzf" })
	use({ "junegunn/fzf.vim" })
	use({ "justinmk/vim-dirvish" })

	use({ "Lokaltog/vim-monotone" })

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

	use({ "nvim-lua/popup.nvim" })
	use({ "nvim-lua/plenary.nvim" })
	use({ "nvim-lua/telescope.nvim" })
	use({
		"nvim-treesitter/nvim-treesitter",
		requires = { "nvim-treesitter/nvim-treesitter-textobjects" },
		run = ":TSUpdate",
	})

	use({
		"nvim-lualine/lualine.nvim",
		requires = { "kyazdani42/nvim-web-devicons", opt = true },
	})
	use({ "rafcamlet/nvim-luapad" })
	use({ "rcarriga/nvim-notify" })
	use({ "rktjmp/lush.nvim" })
	use({ "simnalamburt/vim-mundo" })

	use({
		"skywind3000/asynctasks.vim",
		requires = { "skywind3000/asyncrun.vim" },
	})
	use({ "ThePrimeagen/git-worktree.nvim" })
	use({ "tommcdo/vim-lion" })
	use({ "tpope/vim-commentary" })
	use({ "tpope/vim-eunuch" })
	use({ "tpope/vim-fugitive" })
	use({ "tpope/vim-repeat" })
	use({ "vim-scripts/DoxygenToolkit.vim" })
	use({ "wbthomason/packer.nvim" })

    use '~/projects/playground/neovim/lush/twotone'

	if packer_bootstrap then
		require("packer").sync()
	end
end)
