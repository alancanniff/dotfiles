local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
    execute 'packadd packer.nvim'
end


return require('packer').startup(function()
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    use 'fidian/hexmode'
    use 'honza/vim-snippets'
    use 'itchyny/lightline.vim'
    use { 'junegunn/fzf', run = function() vim.fn['fzf#install()'](0) end }
    use 'junegunn/fzf.vim'
    use 'justinmk/vim-dirvish'
    use 'Lokaltog/vim-monotone'

    if print(vim.fn.executable('ctags')) then
        use 'ludovicchabant/vim-gutentags'
    end

    use 'machakann/vim-sandwich'

    -- use({
    --     'jose-elias-alvarez/null-ls.nvim',
    --     -- config = function()
    --     --     require("null-ls").config({
    --     --         -- you must define at least one source for the plugin to work
    --     --         sources = { require("null-ls").builtins.formatting.shfmt }
    --     --     })
    --     --     require("lspconfig")["null-ls"].setup({ })
    --     -- end,
    --     -- requires = { 
    --     --     'neovim/nvim-lspconfig',
    --     --     'nvim-lua/plenary.nvim'
    --     -- },
    -- })

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

    use 'seletskiy/vim-pythonx'
    use 'simnalamburt/vim-mundo'
    use 'SirVer/ultisnips'
    use {'skywind3000/asynctasks.vim', requires = {'skywind3000/asyncrun.vim'}}
    use 'tommcdo/vim-lion'
    use 'tpope/vim-commentary'
    use 'tpope/vim-eunuch'
    use 'tpope/vim-fugitive'
    use 'tpope/vim-repeat'
    use 'vim-scripts/DoxygenToolkit.vim'
    -- use({'hrsh7th/nvim-cmp', 
    --     requires = { 
    --         'hrsh7th/cmp-nvim-lsp',
    --         'hrsh7th/cmp-buffer',
    --         'hrsh7th/cmp-path',
    --         'hrsh7th/cmp-cmdline',
    --         'quangnguyen30192/cmp-nvim-ultisnips'
    --     },
    --     -- config = function()
    --     --     require('_nvim-cmp')
    --     -- end,
    -- })
end)
