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
    use 'k-takata/minpac'
    use 'kyazdani42/nvim-web-devicons'
    use 'Lokaltog/vim-monotone'
    if print(vim.fn.executable('ctags')) then
        use 'ludovicchabant/vim-gutentags'
    end
    use 'machakann/vim-sandwich'
    use 'michaeljsmith/vim-indent-object'
    use 'neomake/neomake'
    use 'neovim/nvim-lspconfig'
    use 'nvim-lua/completion-nvim'
    use 'nvim-lua/popup.nvim'
    use 'nvim-lua/plenary.nvim'
    use 'nvim-lua/telescope.nvim'
    use 'nvim-treesitter/nvim-treesitter'
    use 'nvim-treesitter/playground'
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
end)
