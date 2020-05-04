
" Assorted Setup and configuration {{{ "

    " K over keyword to goto help for it
    " :h keyword <c-d> brings up list of matching entries

    " instead of reinventing the wheel - you can use these to point to the standard config and cache
    " without explictily using $XDG_CONGIG_HOME / $XDG_CACHE_HOME
    " stdpath('config')
    " stdpath('cache')

    let g:is_windows = has('win32') || has('win64')
    if g:is_windows
        " be expicit about this on windows as cygwin + quartus sets this to bash
        set shell=cmd.exe
    endif

    if has('nvim')
        if g:is_windows
            let g:python_host_prog = 'c:/Tools/Python2/python.exe'
            let g:python3_host_prog = 'c:/Python38/python.exe'
            " let g:python3_host_prog = 'C:/Tools/Python/3.7.1/python.exe'
        endif
    endif

    "set default direcotry for swap files
    set swapfile
    let dir_swap=stdpath('cache').'/swp'
    call my_utils#Make_Directory(dir_swap)
    let &dir= dir_swap.'//,.'

    "set default direcotry for backup files
    set backup                                "enable backup.
    let dir_back=stdpath('cache').'/backup'
    call my_utils#Make_Directory(dir_back)
    let &backupdir=dir_back.'//,.'

" }}} Assorted Setup and configuration

" Packges {{{ "

    if empty(glob(substitute(&packpath, ",.*", "/pack/minpac/opt/minpac", "")))
        call system("git clone --depth=1 https://github.com/k-takata/minpac ".substitute(&packpath, ",.*", "/pack/minpac/opt/minpac", ""))
    endif

    if exists('*minpac#init')
        call minpac#init()
        call minpac#add('adelarsq/vim-matchit')                  " may need support for 2008   see the ftplugins dir in the install dir
        call minpac#add('fidian/hexmode')                        " better support for editing hexfiles
        call minpac#add('haorenW1025/completion-nvim')           " a completion framework
        call minpac#add('haorenW1025/diagnostic-nvim')           " settings wrapper for lsp
        call minpac#add('honza/vim-snippets')                    " library of snippets
        " call minpac#add('itchyny/lightline.vim')                 " a statusline manager
        call minpac#add('junegunn/fzf', { 'do': { -> fzf#install() } })
        call minpac#add('junegunn/fzf.vim')
        call minpac#add('justinmk/vim-dirvish')                  " basic directory tree navigation plug in
        call minpac#add('k-takata/minpac', {'type': 'opt'})
        call minpac#add('Lokaltog/vim-monotone')
        call minpac#add('machakann/vim-sandwich')                " sa - add, sd - delete, sr - replace
        " call minpac#add('neomake/neomake')                       " async maker
        call minpac#add('neovim/nvim-lsp')
        call minpac#add('seletskiy/vim-pythonx')                 " python lib used by ultisnips for autojumping
        call minpac#add('simnalamburt/vim-mundo')                " Undo tree visualisation
        call minpac#add('SirVer/ultisnips')                      " expand code snippet
        call minpac#add('tommcdo/vim-lion')                      " :h lion - glip: --spaces to left of align char, gL adds them to the right
        call minpac#add('tpope/vim-commentary') 
        " call minpac#add('tpope/vim-fugitive') 
        call minpac#add('tpope/vim-repeat') 
        " call minpac#add('vimwiki/vimwiki') 
    endif

    command! PackUpdate packadd minpac | source $MYVIMRC | call minpac#update('', {'do': 'call minpac#status()'})
    command! PackClean  packadd minpac | source $MYVIMRC | call minpac#clean()
    command! PackStatus packadd minpac | source $MYVIMRC | call minpac#status()

" }}} Packages "

" Settings {{{ "
    set guioptions+=M                          " M = don't load menu. has to be run before other options which is why it's done here. See help
    set encoding=utf-8

    filetype plugin indent on                   " this is also needed for UltiSnip
    syntax on                                   " turn on syntax highlighting

    " If you have vim >=8.0 or Neovim >= 0.1.5
    if (has("termguicolors"))
        set termguicolors
    endif

    set wildoptions =pum

    if &wildoptions == "pum"
        cnoremap <up> <c-p>
        cnoremap <down> <c-n>
    endif

    set completeopt=menuone,noinsert,noselect
    set inccommand=nosplit                      " /nosplit/split : Also shows partial off-screen results in a preview window.
    set sessionoptions+=slash                   " covert all paths to use /
    " set backspace=indent,eol,start              " let the backspace key work normally - now the default...
    set hidden                                  " hide unsaved buffers
    set autoread                                " auto read file when changed outside of buffer
    set laststatus=2                            " always show the statusline in the last (bottom) window
    set cmdheight=2                             " set command window height to 2.
    set confirm                                 " Confirm instead of fail a command
    set showmatch                               " show matching brackets
    set shortmess=caAOstT                        " shortens messages to avoid 'press a key' prompt " stops swp file warnings. In windows using --remote-silent opening two files with warnings freezes vim
    set signcolumn=yes                          " always show the sign colum
    set switchbuf=useopen,usetab                " better behavior for the quickfix window and :sb
    set pumheight=10                            " set max height of popupmenu
    "set wildmenu                                " better command line completion, shows a list of matches. using the pum menu in neovim
    set wildmode=longest:full,list:full         " complete to the longest common on the first tab and display all the options, then select the first on the next one
    set wildignore=*.swp,*.bak                  " ignore these file in the
    set title                                   " change the terminal's title
    set nowrap                                  " turn off line wrap
    set mouse=a                                  " going to play with gvim. Turn off mouse. It's too tempting.
    set formatoptions-=c                        " Auto-wrap comments using textwidth, inserting the current comment leader automatically.
    set formatoptions-=r                        " Automatically insert the current comment leader after hitting <Enter> in Insert mode.
    set formatoptions-=o                        " Automatically insert the current comment leader after hitting 'o' or 'O' in Normal mode.
    set formatoptions+=j                        " Delete comment character when joining commented lines

    set guioptions+=a                           " 'a'   autoselect
    set guioptions+=!                           " '!'   External commands executed in a terminal window
    set guioptions+=c                           " 'c'   Use console dialogs instead of popup dialogs for simple choices.
    set guioptions-=e                           " 'e'   don't use the gui tabline.
    set guioptions-=m                           " 'm'   Menu bar is present.
    set guioptions-=T                           " 'T'   Include Toolbar.  Currently only in Win32, GTK+, Motif, Photon and Athena GUIs.
    set guioptions-=r                           " 'r'   Right-hand scrollbar is always present.
    set guioptions-=L                           " 'L'   Left-hand scrollbar is present when there is a vertically split window.
    set cursorline                              " highlight current line
    set cursorcolumn                            " highlight current col

    set autoindent
    set tabstop=8                               " The width of a hard tabstop measured in spaces
    set softtabstop=4                           " when hitting tab or backspace, how many spaces should a tab be (see expandtab)
    set shiftwidth=4                            " size of indent
    set expandtab                               " uses spaces instead of tab

    set virtualedit=all                         " move the cursor anywhere on the screen
    set history=1000                            " increase the history buffer
    set scrolloff=3                             " leave 3 lines when scolling
    set sidescrolloff=5                         " leave 5 columns when scrolling/
    set sidescroll=5                            " only scroll by 5 char, not a half page
    set hlsearch                                " light searches
    set visualbell                              " Use visual bell instead of beeping when doing something wrong
    set noerrorbells                            " turn off the error bells
    set belloff=all
    set ignorecase                              " ignore case when searching.
    set smartcase                               " ignore case unless you use capitals in the search
    set showcmd                                 " Show partial commands in the last line of the screen
    set display=lastline                        " show as much as possible for the last command. @@@ indicates truncate
    set nrformats-=octal                        " remove octal from increment command
    set noinfercase                             " infer case in completionl
    set noshowmode                              " don't show the mode in the command line as it's in airline
    set foldenable                              " enable folding
    set foldmethod=marker                       " enable folding at option - markers
    set foldmarker={{{,}}} 
    set foldnestmax=1
    set foldopen=block,hor,jump,mark,quickfix,search,tag " what movements open folds - hor is horizontal
    set lazyredraw                              " Don't redraw while executing macros (good performance config) 
    set timeoutlen=3000
    set incsearch                             " incremental search rules
    set fillchars=vert:\┃,fold:-
    set list
    set listchars=tab:▸\ ,trail:·,extends:>,precedes:<,nbsp:+
    set nonumber                                " show line numbers
    set relativenumber                        " line nubers are relative to the current one
    set numberwidth=5                           " We are good up to 99999 lines
    " set pastetoggle=<F12>
    " set mousemodel=popup

    "set diffopt-=internal
    set diffopt+=algorithm:patience
    " algorithm:{text} Use the specified diff algorithm with the
    " internal diff engine. Currently supported 
    " algorithms are:
    " myers      the default algorithm
    " minimal    spend extra time to generate the
    " smallest possible diff
    " patience   patience diff algorithm
    " histogram  histogram diff algorithm




" }}} Settings "

" Key Mappings {{{ "
   " :map {key sequence} returns the current assignment for the sequence

    " \\ \/ toggle forward and back slash on the current line
    nnoremap <silent> \/ :let tmp=@/<Bar>s:\\:/:ge<Bar>let @/=tmp<Bar>noh<CR>
    nnoremap <silent> \\ :let tmp=@/<Bar>s:/:\\:ge<Bar>let @/=tmp<Bar>noh<CR>

    " mapping for FZF, Files, lines in buffer, lines in all buffers, History, cmd hist, search hist
    nnoremap  gb  :ls<CR>:b<Space>
    nnoremap  gB  :ls<CR>:vb<Space>

    " copy some of the mappings from unimpared.
    nnoremap  [B :bfirst<CR>
    nnoremap  [b :bprevious<CR>
    nnoremap  ]b :bnext<CR>
    nnoremap  ]B :blast<CR>

    nnoremap  [T :tfirst<CR>
    nnoremap  [t :tprevious<CR>
    nnoremap  ]t :tnext<CR>
    nnoremap  ]T :tlast<CR>

    nnoremap  [Q :cfirst<CR>
    nnoremap  [q :cprevious<CR>
    nnoremap  ]q :cnext<CR>
    nnoremap  ]Q :clast<CR>

    nnoremap  [L :lfirst<CR>
    nnoremap  [l :lprevious<CR>
    nnoremap  ]l :lnext<CR>
    nnoremap  ]L :llast<CR>

    nnoremap  <SPACE>o o<ESC>
    nnoremap  <SPACE>O O<ESC>

    nnoremap <C-]> g<C-]>

    " change the behaviour of jump to last mark so ' gets me to the exact positio, and not just the line
    nnoremap  ' `
    nnoremap  ` '

    nnoremap  \cd :cd %:p:h<CR>|:pwd

    " remove last search highlighting -- taken from tpopes vim-sensible
    if maparg('<C-L>', 'n') ==# ''
        nnoremap <silent> <C-L> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>
    endif

    " Y yanks to end of line, line D and C (not like yy)
    map Y y$

    if has('nvim')
        "automatically yank mouse selections to the system clipboard
        noremap <LeftRelease> <LeftRelease>"*y
        tnoremap <ESC> <C-\><C-n>
        tnoremap <C-w> <C-\><C-n><C-w>
    endif   

    " CTRL-U in insert mode deletes a lot.  break the undo sequnce of better undo
    inoremap <C-U> <C-G>u<C-U>

    " this function has been moved to the plugins dir
    nmap \h <Plug>Highlight_SynStack

    " Close location list or quickfix list if they are present,
    " see https://goo.gl/uXncnS
    nnoremap<silent> \x :windo lclose <bar> cclose<CR>

    " Close a buffer and switching to another buffer, do not close the window, 
    " see https://goo.gl/Wd8yZJ
    nnoremap <silent> \d :bprevious <bar> bdelete #<CR>

"" }}} Key Mappings "

" Autocmd {{{ "

    " group the commands so they are cleared when you re-source the vimrc file.
    augroup aug_general " {
        autocmd!

        " set the format options I want. always.
        "autocmd FileType * setlocal formatoptions+=j formatoptions-=c formatoptions-=r formatoptions-=o
        "autocmd FileType erf :Hexmode

        " auto reload files with a warning message
        " https://unix.stackexchange.com/questions/149209/refresh-changed-content-of-file-opened-in-vim/383044#383044
        " autocmd FocusGained,BufEnter * :checktime
        autocmd FileChangedShellPost * echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None

        " Remove trailing white spaces. This is dangerous for some filetypes - like this one!
        autocmd BufWritePre *.tcl,*.py,*.bash,*.sh,*.vhd,*.csh,*.cpp,*.c silent! :call my_utils#Trim_Whitespace()<CR>
        " autocmd FileType python nnoremap \y :0,$!yapf<Cr><C-o> :w<CR>

        " Jump to last know position in a file (if the '" is set)
        autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | execute 'normal! g`"zvzz' | endif

        " source vimrc after you save it
        autocmd BufWritePost init.vim nested source $MYVIMRC 
        autocmd BufRead,BufNewFile *.inc set filetype=make

        autocmd BufLeave * :set nocursorcolumn | set nocursorline
        autocmd BufEnter * :set cursorcolumn | set cursorline

        autocmd BufNewFile * :set fileformat=unix

        "delete netrw buffers when they become hidden
        autocmd FileType netrw setl bufhidden=delete
        autocmd FileType dirvish setl bufhidden=delete

    augroup END " }

" }}} Autocmd "

" Taglist {{{ "
    set tags=./TAGS;/,TAGS;/                  " search tags files efficiently
    set notagrelative                           " If tags file in another directory, filenames in that file are not relative (absolute)
    set noautochdir                             " always switch to the current file directory. Turning this off because of tags
" }}} Taglist "

" colorscheme {{{ "
    augroup aug_colorscheme " {
        autocmd!
        autocmd ColorScheme monotone call my_utils#Monotone_Mods()
    augroup END " }

    " make sure the autocmd is set before configuring the colorscheme
    silent! colorscheme monotone
" }} " colorscheme


      
