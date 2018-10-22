set nocompatible
 
" <c-k> over keyword to goto help for it
" zc close a fold under cursor
" zM close all
" zR open all
 
"{{{ setup and windows config
    let windows = has('win32') || has('win64')
    let unix    = has('unix')

    let g:my_config_home = $HOME.'/.config'
    let g:my_cache_home = $HOME.'/.cache'

    let g:my_config_vim = g:my_config_home.'/vim'
    let g:my_config_vim = substitute(g:my_config_vim, '\', '/', 'g')

    if !isdirectory(g:my_config_vim)
        call mkdir(g:my_config_vim, "p")
    endif

    let g:my_cache_vim = g:my_cache_home.'/vim'
    let g:my_cache_vim = substitute(g:my_cache_vim, '\', '/', 'g')

    if !exists("g:my_dont_reload") 
        " don't reload when this file is saved as it breaks the plugins by clearing them from the rtp
        " in windows call a file '.vimrc.' to create .vimrc - .vim. to get .vim directory
        " the & indicates the let is setting a setting, not a variable
        let &runtimepath=g:my_config_vim.",$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,".g:my_config_vim."/after"
        let &packpath=g:my_config_vim.",$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,".g:my_config_vim."/after"
    endif

    "set default direcotry for swap files
    let dir_swap=g:my_cache_vim.'/swp'
    if !isdirectory(dir_swap)
        call mkdir(dir_swap, "p")
    endif
    let &dir= dir_swap.'//,.'
 
    "set default direcotry for backup files
    set backup                                "enable backup
    let dir_back=g:my_cache_vim.'/backup'
    if !isdirectory(dir_back)
        call mkdir(dir_back, "p")
    endif
    let &backupdir=dir_back.'//,.'

    "if has('persistent_undo')
    "    set undofile                                "enable persistent undo
    "    let dir_undo=g:my_cache_vim.'/undo'
    "    if !isdirectory(dir_undo)
    "        call mkdir(dir_undo, "p")
    "    endif
    "    let &undodir=dir_undo.'//,.'
    "endif

" }}}

" {{{ packages -- minpac

    function! PackInit() abort
        packadd minpac
        call minpac#init()
        call minpac#add('k-takata/minpac', {'type':'opt'})      " let minpac manage itself
        "call minpac#add('scrooloose/nerdtree', {'type': 'opt'}) " direcoty tree vim style
        "call minpac#add('vim-syntastic/syntastic')
        call minpac#add('tpope/vim-vinegar')                    " basic directory tree navigation plug in
        call minpac#add('tpope/vim-surround')                   " for swapping around braces: change - cs([, delete - ds(, added - ysiw(
        call minpac#add('tpope/vim-fugitive')
        call minpac#add('SirVer/ultisnips')                     " expand code snippet
        call minpac#add('honza/vim-snippets')                   " library of snippets
        call minpac#add('vim-airline/vim-airline')              " fancy status line
        call minpac#add('vim-airline/vim-airline-themes')       " airline themes
        call minpac#add('tommcdo/vim-lion')                     " :h lion       glip: --spaces to left of align char, gL adds them to the right
        call minpac#add('junegunn/fzf')                         " installed the binary using chocolatey on windows
        call minpac#add('junegunn/fzf.vim')                     " fuzzy finder for loads of differnt things
        call minpac#add('Znuff/consolas-powerline')             " a power line font...
        call minpac#add('Znuff/consolas-powerline')             " a power line font...
        call minpac#add('vimwiki/vimwiki')
        
        " vhdl stuff...
        call minpac#add('neomake/neomake')
    endfunction

    command! PackUpdate call PackInit() | call minpac#update()
    command! PackClean  call PackInit() | call minpac#clean()
    command! PackStatus call PackInit() | call minpac#status()

"}}}

" {{{ SETTINGS
    set encoding=utf-8

    filetype plugin indent on                   " this is also needed for UltiSnip
    syntax enable                               " turn on syntax highlighting -- using on instead of enable overrides settings with defaults

    " If you have vim >=8.0 or Neovim >= 0.1.5
    if (has("termguicolors"))
        set termguicolors
    endif

    if !exists("g:my_dont_reload") 
        set guifont=Consolas_NF:h11:cANSI:qDRAFT,Consolas:h11 " Consolas_NF is the powerline font
    "    set guifont=Noto_Mono_for_Powerline:h10:cANSI:qDRAFT
    endif

    set backspace=indent,eol,start              " let the backspace key work normally
    set hidden                                  " hide unsaved buffers
    set autoread                                " auto read file when changed outside of buffer
    set list                                    " show hidden characters -^I is tab
    set laststatus=2                            " always show the statusline in the last (bottom) window
    set confirm                                 " Confirm instead of fail a command
    set cmdheight=2                             " set command window height to 2.
    set showmatch                               " show matching brackets
    set autochdir                               " always switch to the current file directory.. Messes with some plugins, but I like it
    set shortmess=aAOstT                         " shortens messages to avoid 'press a key' prompt " stops swp file warnings. In windows using --remote-silent opening two files with warnings freezes vim
    set switchbuf=useopen,usetab                " better behavior for the quickfix window and :sb
    set wildmenu                                " better command line completion, shows a list of matches
    set wildignore=*.swp,*.bak                  " ignore these file in the
    set title                                   " change the terminal's title
    set nowrap                                  " turn off line wrap
    set textwidth=0                             " stop line breaks when writing.
    set mouse=                                  " going to play with gvim. Turn off mouse. It's too tempting.
    set guioptions=eg                           " hide it all. m = menu bar, T = toolbar, r = right-hand scroll bar, L left-hand scroll bar
    set clipboard+=unnamed                      " share windows clip board
    set formatoptions-=cro                      " turn off auto comment. there's an example of how to set this per filetype
    set formatoptions+=j                        " remove comment tag when joining lines
    set cursorline                              " highlight current line
    set cursorcolumn                            " highlight current col
    set tabstop=8                               " The width of a hard tabstop measured in spaces
    set softtabstop=4                           " when hitting tab or backspace, how many spaces should a tab be (see expandtab)
    set expandtab                               " uses spaces instead of tab
    set shiftwidth=4                            " size of indent
    set smarttab                                " 
    "set noexpandtab                             " uses spaces instead of tab
    set virtualedit=all                         " move the cursor anywhere on the screen
    set history=100                             " increase the history buffer
    set scrolloff=3                             " leave 3 lines when scolling
    set sidescrolloff=5                         " leave 5 columns when scrolling/
    set sidescroll=5                            " only scroll by 5 char, not a half page
    set hlsearch                                " light searches
    set visualbell                              " Use visual bell instead of beeping when doing something wrong
    set ignorecase                              " ignore case when searching.
    set smartcase                               " ignore case unless you use capitals in the search
    set showcmd                                 " Show partial commands in the last line of the screen
    set display=truncate                        " Show @@@ in the last line if it is truncated.
    set nrformats-=octal
    set noinfercase                             " infer case in completionl
    set noshowmode                              " don't show the mode in the command line as it's in airline
    " set omnifunc                                " enable completion <c-x><c-o> 
    set foldenable                              " enable folding
    set foldmethod=marker                       " enable folding at option - markers
    set foldmarker={{{,}}} 
    set foldnestmax=1
    "set foldlevel=100                               " Don't autofold anything (but I can still fold manually)
    set foldopen=block,hor,jump,mark,quickfix,search,tag " what movements open folds - hor is horizontal
    set splitbelow                              " default split behavior
    set splitright                              " default split behavior
    set lazyredraw                              " Don't redraw while executing macros (good performance config) 
    set noerrorbells                            " turn off the error bells
    "set novisualbell
    "set t_vb=
    "set tm=500
    set incsearch                             " incremental search rules
    set listchars=tab:▸·,trail:·,eol:¬
    set nonumber                                " show line numbers
    set relativenumber                        " line nubers are relative to the current one
    set numberwidth=5                           " We are good up to 99999 lines
    " colorscheme tempus_warp                         " modified darkblue color scheme, with edges match the dark color scheme in airline
    "  http://bytefluent.com/vivify/index.php       " a site for editing colorscheme
    colorscheme darkblue_modified                         " modified darkblue color scheme, with edges match the dark color scheme in airline
" }}}

" {{{ STATUSLINE
    set statusline=                             " clear the statusline for when vimrc is reloaded
    set statusline+=%-3.3n\                     " buffer number
    set statusline+=%f\                         " file name
    set statusline+=%h%m%r%w                    " flags
    set statusline+=[%{strlen(&ft)?&ft:'none'}, " filetype
    set statusline+=%{&fileformat}]             " file format
    set statusline+=%=
    set statusline+=%10((%l/%L,%c)%)\           " line and column
    set statusline+=%P\                         " percentage of file
" }}}

" {{{ KEY MAPPINGS
    " :map {key sequence} returns the current assignment for the sequence

    " \\ \/ toggle forward and back slash on the current line
    nnoremap <silent> <Leader>/ :let tmp=@/<Bar>s:\\:/:ge<Bar>let @/=tmp<Bar>noh<CR>
    nnoremap <silent> <Leader><Bslash> :let tmp=@/<Bar>s:/:\\:ge<Bar>let @/=tmp<Bar>noh<CR>
    " full screen in windows
    nnoremap  <Leader>f :simalt ~x<CR>
    " toggle the column highlighting 
    nnoremap <Leader>c :set cursorline! cursorcolumn!<CR>
    " Start interactive EasyAlign in visual mode (e.g. vipga)

    " remove last search highlighting
    nnoremap <C-L> :nohl<CR><C-L>
    nnoremap  :simalt ~x

    " keep things visually selected when you indent them
    " vnoremap < <gv
    " vnoremap > >gv

    " Y yanks to end of line, line D and C (not like yy)
    " map Y y$

    " Don't use Ex mode, use Q for formatting. Revert with :unmap Q".
    "map Q gq

    " CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
    " so that you can undo CTRL-U after inserting a line break.
    " Revert with ":iunmap <C-U>".
    inoremap <C-U> <C-G>u<C-U>

" }}}

" {{{ autocmd
    " only enable autocmds when they're supported
    if has("autocmd")

        function! Trim_Whitespace()
            let l:save = winsaveview()
            keeppatterns %s/\s\+$//e
            call winrestview(l:save)
        endfunction

        " group the commands so they are cleared when you re-source the vimrc file.
        augroup my_vim_commands " {
            autocmd!

            " For all text files set 'textwidth' to 78 characters.
            " autocmd FileType text setlocal textwidth=78

            "exapmple of per type tabsettings
            "autocmd FileType javascript setlocal ts=4 sts=4 sw=4 noexpandtab
            autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o      " turn off autocomment
            autocmd FileType make set noexpandtab shiftwidth=8 softtabstop=0

            " AUTOCOMMAND
            autocmd BufRead,BufNewFile *.do set filetype=tcl                                    " open do files as tcl
            autocmd BufRead,BufNewFile *.ttcl set filetype=tcl                                  " open ttcl files as tcl
            autocmd BufRead,BufNewFile *.xdc set filetype=tcl                                   " open xdc files as tcl
            autocmd BufRead,BufNewFile *.vhdm set filetype=vhdl                                 " open vhdm files as vhdl
            autocmd BufRead,BufNewFile *.psl set filetype=vhdl                                  " open psl files as vhdl
            autocmd BufRead,BufNewFile *.vho set filetype=vhdl                                  " open template files as vhdl

            " auto reload files with a warning message
            " https://unix.stackexchange.com/questions/149209/refresh-changed-content-of-file-opened-in-vim/383044#383044
            " try do something about the dialog box in gvim
            autocmd FocusGained,BufEnter * :checktime
            autocmd FileChangedShellPost * echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None

            " Remove trailing white spaces. This is dangerous for some filetypes - like this one!
            autocmd BufWritePre *.vhd,*.csh,*.cpp,*.c silent! :call Trim_Whitespace()<CR>

            " Jump to last know position in a file (if the '" is set)
            autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

            " Template for new vhdl files.
            " :wautocmd BufNewFile *.vhd silent! execute '0r $my_OneDrive/Vim/templates/skeleton.vhd'

            " source vimrc after you save it
            autocmd BufWritePost vimrc.vim source $MYVIMRC
            autocmd BufWritePost *.vhd call neomake#configure#automake('w')

            " start the gui maximized
            if windows
                autocmd GUIEnter * simalt ~x
            endif

        augroup END " }
    endif " has("autocmd")
" }}}

" {{{ Taglist
    " ok so ctags needs to be installed - chocolatey has it if windows.
    " ctags needs to be runs in the directory you want to index - ctags -R .
    " this creaetes a tags file
    " this will search in the current file directory, then up the directory tree
    set tags=./tags;/,tags;/                  " search tags files efficiently
    " for vhdl the support is poor. you can improve it with a .ctags file in home dir 
    " (to name a file starting with . call it '.ctags.'
    " home dir is $HOME  or $HOMEPATH + $HOMEDRIVE - posssibley...
    " <C-]> goto tag
    " g] open list of matching tags
    " <C-t> jump to entry on tag list, default is the last placed you jumped from
    " <C-w><C-]> open tag in horizontal window
    " <C-w>} open tag in preview window - as in open a new window, but don't move cursor into it
    " <C-w>g] open tag list - then open selected in horizontal window
    " let g:tlist_vhdl_settings   = 'vhdl;d:package declarations;b:package bodies;e:entities;a:architecture specifications;t:type declarations;p:processes;f:functions;r:procedures'
" }}}

" {{{ Ultisnips
 
    let g:my_config_ultisnips = g:my_config_home.'/UltiSnips'

    if !isdirectory(g:my_config_ultisnips)
        call mkdir(g:my_config_ultisnips, "p")
    endif
 
    let g:UltiSnipsExpandTrigger="<tab>"                    " this is the default - tab expands snippet (<c-j> goes to next field
    let g:UltiSnipsSnippetsDir=g:my_config_ultisnips
    "let g:UltiSnipsSnippetsDir= join([g:my_home, "UltiSnips"], '/')     " ultisnips didn't like using string concatonation in this global 
    let g:UltiSnipsEditSplit="horizontal"                   " show this snippet file in a horizontal split
" }}}

" {{{ Airline
    let g:airline_detect_spell=0                            " I never use spelling in vim, so turn it off
    let g:airline_detect_spelllang=0                        " ^^
    let g:airline_section_c = '%t'                          " only display the filename
    let g:airline_powerline_fonts = 1                       " powerline fonts for facny airline look
    " let g:airline_section_z = '%l/%L-%c'              " line and column
    " let g:airline_theme='darkblue'
" }}}

" {{{ Easy Align -- Taken from VHDL tool. Needs figured out
    """""" align vhdl signals !! '<,'>EasyAlign */:=*/
    """""" which is EasyAlign *{all occurencse}/{regex}:=*{colon, which may has equal}/{end regex}
    "let g:easy_align_delimiters = {  ':': { 'pattern': ':', 'left_margin': 1, 'right_margin': 1, 'stick_to_left': 0 },  }
    "let g:easy_align_delimiters = {  '"': { 'pattern': ':', 'left_margin': 1, 'right_margin': 1, 'stick_to_left': 0 },  }
" }}}

" {{{ Neomake
    " When writing a buffer (no delay).
    " call neomake#configure#automake('w')
    let g:neomake_open_list = 2
    let g:neomake_ghdl_args = ['-s', '--ieee=synopsys', '--work=vhdltool_lib']
    let g:neomake_logfile = g:my_cache_vim.'/neomake.log'
" }}}

" {{{ vimwiki
    let g:vimwiki_list = [ {'path': g:my_config_home.'/vimwiki'} ]
" }}}

"stop sourcing this file from clearing the rtp / packpath in windows. 
" stop guifonts from resizing the window
let g:my_dont_reload = 1

