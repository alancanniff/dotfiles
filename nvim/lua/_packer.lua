local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
    packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end


return require('packer').startup(function()
    -- use { 'alexghergh/nvim-tmux-navigation'}
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    use 'fidian/hexmode'
    use 'itchyny/lightline.vim'
    use 'junegunn/fzf'
    use 'junegunn/fzf.vim'
    use 'justinmk/vim-dirvish'
    use 'Lokaltog/vim-monotone'

    if vim.fn.executable('ctags') == 1 then
        use 'ludovicchabant/vim-gutentags'
    end

    use 'machakann/vim-sandwich'

    use({
        'jose-elias-alvarez/null-ls.nvim',
        config = function()
            require("_null-ls")
        end,
        requires = { 
            'neovim/nvim-lspconfig',
            'nvim-lua/plenary.nvim'
        },
    })

    use({
        'L3MON4D3/LuaSnip',
        requires = {'honza/vim-snippets'},
        config = function()
            require('_LuaSnip')
        end,
    })

    use 'michaeljsmith/vim-indent-object'
    use({
        'neovim/nvim-lspconfig',
        config = function()
            require('_lspconfig')
        end,
    })
    
    use 'nvim-lua/popup.nvim'
    use 'nvim-lua/plenary.nvim'
    use({
        'nvim-lua/telescope.nvim', 
        cofig = function()
            require('_telescope')
        end,
    })
    use({
        'nvim-treesitter/nvim-treesitter',
        config = function()
            require('_tree-sitter')
        end,
    })

    use 'rktjmp/lush.nvim'
    use 'simnalamburt/vim-mundo'

    use {'skywind3000/asynctasks.vim', requires = {'skywind3000/asyncrun.vim'}}
    use 'tommcdo/vim-lion'
    use 'tpope/vim-commentary'
    use 'tpope/vim-eunuch'
    use 'tpope/vim-fugitive'
    use 'tpope/vim-repeat'
    use 'vim-scripts/DoxygenToolkit.vim'

    if packer_bootstrap then
        require('packer').sync()
    end
end)
