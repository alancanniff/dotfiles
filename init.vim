" K over keyword to goto help for it
" :h keyword <c-d> brings up list of matching entries

set guioptions+=M                          " M = don't load menu. has to be run before other options which is why it's done here. See help

if has('nvim')
    let g:python_host_prog = 'c:/Python27/python.exe'
    let g:python3_host_prog = 'C:/Tools/Python/3.7.1/python.exe'
endif

" Functions {{{ "
function! Make_Directory(path)
    if !isdirectory(a:path)
        call mkdir(a:path, "p", 0700)
    endif
endfunction
" }}} Functions "
" Directory and rtp config {{{ "

    let windows = has('win32') || has('win64')

    " convert all back slashes to forward slashes
    let g:my_config_home = substitute($HOME.'/.config', '\', '/', 'g')
    let g:my_cache_home = substitute($HOME.'/.cache', '\', '/', 'g')

    let g:my_config_vim = g:my_config_home.'/vim'
    call Make_Directory(g:my_config_vim)

    let g:my_cache_vim = g:my_cache_home.'/vim'

    " don't reload when this file is saved as it breaks the plugins by clearing them from the rtp
    if !exists("g:my_dont_reload") 
        " in windows call a file '.vimrc.' to create .vimrc - .vim. to get .vim directory
        let &runtimepath=g:my_config_vim.",".&runtimepath
        let &runtimepath.=",".g:my_config_vim."/after"
        let &packpath = &runtimepath
    endif

    "set default direcotry for swap files
    set swapfile
    let dir_swap=g:my_cache_vim.'/swp'
    call Make_Directory(dir_swap)
    let &dir= dir_swap.'//,.'

    "set default direcotry for backup files
    set backup                                "enable backup
    let dir_back=g:my_cache_vim.'/backup'
    call Make_Directory(dir_back)
    let &backupdir=dir_back.'//,.'

" }}} Directory and rtp config "
" Packges {{{ "

    function! PackInit() abort
        packadd minpac
        call minpac#init()
        call minpac#add('k-takata/minpac', {'type':'opt'})      " let minpac manage itself
        call minpac#add('tpope/vim-vinegar')                    " basic directory tree navigation plug in
        call minpac#add('machakann/vim-sandwich')
        call minpac#add('tpope/vim-fugitive')
        call minpac#add('tpope/vim-commentary')
        call minpac#add('tpope/vim-repeat')
        call minpac#add('SirVer/ultisnips')                     " expand code snippet
        call minpac#add('honza/vim-snippets')                   " library of snippets
        call minpac#add('seletskiy/vim-pythonx')                " python lib used by ultisnips for autojumping
        call minpac#add('Znuff/consolas-powerline')             " a power line font...
        call minpac#add('itchyny/lightline.vim')                " a statusline manager
        call minpac#add('tommcdo/vim-lion')                     " :h lion - glip: --spaces to left of align char, gL adds them to the right
        call minpac#add('junegunn/fzf')                         " fuzzy finder for loads of differnt things
        call minpac#add('junegunn/fzf.vim')                     " fuzzy finder for loads of differnt things
        call minpac#add('vimwiki/vimwiki')
        call minpac#add('adelarsq/vim-matchit')                 " may need support for 2008   see the ftplugins dir in the install dir
        call minpac#add('neomake/neomake')                      " async maker
        call minpac#add('michaeljsmith/vim-indent-object')      "  ai = an indent object and line above, ii an indent object, aI an indent object and lines above/below
        call minpac#add('unblevable/quick-scope')               " highlights letters for easier spotting of f/t actios; :QuickScopeToggle to turn it off
        call minpac#add('fidian/hexmode')                       " better support for editing hexfiles
        call minpac#add('equalsraf/neovim-gui-shim')            " 
        " call minpac#add('romainl/vim-cool')
        " colorschemes
        call minpac#add('Lokaltog/vim-monotone')
    endfunction

    command! PackUpdate call PackInit() | call minpac#update() | call minpac#update('', {'do': 'call minpac#status()'})
    command! PackClean  call PackInit() | call minpac#clean()
    command! PackStatus call PackInit() | call minpac#status()
    
    "packadd python-mode

" }}} Packages "
" Packages Config {{{ "
    "see after\plugin\airline.vim
    "see after\plugin\lightline.vim
    "see after\plugin\neomake.vim
    "see after\plugin\quick-scope.vim
    "see after\plugin\netrw.vim
    let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']
    let g:vimwiki_list = [ {'path': g:my_config_home.'/vimwiki'} ]
" }}} Packages Config "
" Settings {{{ "

    set encoding=utf-8

    filetype plugin indent on                   " this is also needed for UltiSnip
    syntax on                                   " turn on syntax highlighting

    " If you have vim >=8.0 or Neovim >= 0.1.5
    if (has("termguicolors"))
        set termguicolors
    endif

    " chagning the guifont in Windows was resizing the window. don't reload it when souring this file
    if !exists("g:my_dont_reload") 
        if !has('nvim')
            set guifont=Consolas_NF:h11:cANSI:qDRAFT,Consolas:h11 " Consolas_NF is the powerline font
        endif
    "    set guifont=Anonymice_Powerline:h11:cANSI:qDRAFT
    endif

    if !has('nvim')
        let &viminfofile=g:my_cache_vim.'/viminfo'
    else        
        set wildoptions =pum

        if &wildoptions == "pum"                                                                                                                
            cnoremap <up> <c-p>
            cnoremap <down> <c-n>
        endif
    endif

    set sessionoptions+=slash                   " covert all paths to use /
    set backspace=indent,eol,start              " let the backspace key work normally
    set hidden                                  " hide unsaved buffers
    set autoread                                " auto read file when changed outside of buffer
    set laststatus=2                            " always show the statusline in the last (bottom) window
    set cmdheight=2                             " set command window height to 2.
    set confirm                                 " Confirm instead of fail a command
    set showmatch                               " show matching brackets
    set shortmess=aAOstT                        " shortens messages to avoid 'press a key' prompt " stops swp file warnings. In windows using --remote-silent opening two files with warnings freezes vim
    set switchbuf=useopen,usetab                " better behavior for the quickfix window and :sb
    "set wildmode=list,full                     " on 1st tab, complete 1st match and list options in popup windows
    "set wildmode=list:longest,list:full              " on 1st tab, complete longest common string, on 2nd complete fully
    "set wildmenu                                " better command line completion, shows a list of matches
    set wildignore=*.swp,*.bak                  " ignore these file in the
    set title                                   " change the terminal's title
    set nowrap                                  " turn off line wrap
    " set textwidth=0                             " stop line breaks when writing.
    set mouse=a                                  " going to play with gvim. Turn off mouse. It's too tempting.
    set formatoptions-=c                        " Auto-wrap comments using textwidth, inserting the current comment leader automatically.
    set formatoptions-=r                        " Automatically insert the current comment leader after hitting <Enter> in Insert mode.
    set formatoptions-=o                        " Automatically insert the current comment leader after hitting 'o' or 'O' in Normal mode.
    set formatoptions+=j                        " Delete comment character when joining commented lines

    set guioptions+=a                           " '!'   External commands executed in a terminal window
    set guioptions+=!                           " '!'   External commands executed in a terminal window
    set guioptions+=c                           " 'c'   Use console dialogs instead of popup dialogs for simple choices.
    set guioptions-=e                           " 'e'   don't use the gui tabline.
    set guioptions-=m                           " 'm'   Menu bar is present.
    set guioptions-=T                           " 'T'   Include Toolbar.  Currently only in Win32, GTK+, Motif, Photon and Athena GUIs.
    set guioptions-=r                           " 'r'   Right-hand scrollbar is always present.
    set guioptions-=L                           " 'L'   Left-hand scrollbar is present when there is a vertically split window.
    set cursorline                              " highlight current line
    set cursorcolumn                            " highlight current col
    set tabstop=4                               " The width of a hard tabstop measured in spaces
    set softtabstop=4                           " when hitting tab or backspace, how many spaces should a tab be (see expandtab)
    set expandtab                               " uses spaces instead of tab
    set shiftwidth=4                            " size of indent
    set virtualedit=all                         " move the cursor anywhere on the screen
    set history=1000                            " increase the history buffer
    set scrolloff=3                             " leave 3 lines when scolling
    set sidescrolloff=5                         " leave 5 columns when scrolling/
    set sidescroll=5                            " only scroll by 5 char, not a half page
    set hlsearch                                " light searches
    set visualbell                              " Use visual bell instead of beeping when doing something wrong
    set noerrorbells                            " turn off the error bells
    set belloff=all
    set t_vb=
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

    " I'm remoting into enough machines what this might be annoying
    " set splitbelow                              " default split behavior
    " set splitright                              " default split behavior
    set lazyredraw                              " Don't redraw while executing macros (good performance config) 
    set timeoutlen=3000
    set incsearch                             " incremental search rules
    set fillchars=vert:\┃,fold:-
    set list
    set listchars=tab:▸\ ,trail:·,extends:>,precedes:<,nbsp:+
    set nonumber                                " show line numbers
    set relativenumber                        " line nubers are relative to the current one
    set numberwidth=5                           " We are good up to 99999 lines
    "  http://bytefluent.com/vivify/index.php       " a site for editing colorscheme
    if windows
        " set shell=c:\cygwin64\bin\bash.exe
        " set shell=C:\cygwin\bin\bash.exe
    endif

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

    " colorscheme darkblue_modified                         " modified darkblue color scheme, with edges match the dark color scheme in airline
    
" }}} Settings "
" Key Mappings {{{ "
   " :map {key sequence} returns the current assignment for the sequence

    " \\ \/ toggle forward and back slash on the current line
    nnoremap <silent> <Leader>/ :let tmp=@/<Bar>s:\\:/:ge<Bar>let @/=tmp<Bar>noh<CR>
    nnoremap <silent> <Leader><Bslash> :let tmp=@/<Bar>s:/:\\:ge<Bar>let @/=tmp<Bar>noh<CR>
    " full screen in windows
    " nnoremap  <Leader>f :simalt ~x<CR>

    " mapping for FZF, Files, lines in buffer, lines in all buffers, History, cmd hist, search hist
    nnoremap  <SPACE>f :Files<CR>
    nnoremap  <SPACE>l :BLines<CR>
    nnoremap  <SPACE>L :Lines<CR>
    nnoremap  <SPACE>t :BTags<CR>
    nnoremap  <SPACE>h :History<CR>
    nnoremap  <SPACE>: :History:<CR>
    nnoremap  <SPACE>/ :History/<CR>
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

    " change the behaviour of jump to last mark so ' gets me to the exact positio, and not just the line
    nnoremap  ' `
    nnoremap  ` '

    nnoremap  \cd :cd %:p:h<CR>

    " remove last search highlighting -- taken from tpopes vim-sensible
    if maparg('<C-L>', 'n') ==# ''
        nnoremap <silent> <C-L> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>
    endif
    nnoremap  :simalt ~x

    " Y yanks to end of line, line D and C (not like yy)
    map Y y$

    if has('nvim')
        "automatically yank mouse selections to the system clipboard
        noremap <LeftRelease> <LeftRelease>"*y
        tnoremap <ESC> <C-\><C-n> 
        tnoremap <C-w> <C-\><C-n><C-w>
    endif   
    " CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
    " so that you can undo CTRL-U after inserting a line break.
    " Revert with ":iunmap <C-U>".
    inoremap <C-U> <C-G>u<C-U>

    " this function has been moved to the plugins dir
    nmap \h <Plug>Highlight_SynStack

" }}} Key Mappings "
" Autocmd {{{ "
    " only enable autocmds when they're supported
    if has("autocmd")

        " group the commands so they are cleared when you re-source the vimrc file.
        augroup aug_general " {
            autocmd!

            " set the format options I want. always.
            autocmd FileType * setlocal formatoptions+=j formatoptions-=c formatoptions-=r formatoptions-=o

            " AUTOCOMMAND

            " auto reload files with a warning message
            " https://unix.stackexchange.com/questions/149209/refresh-changed-content-of-file-opened-in-vim/383044#383044
            " try do something about the dialog box in gvim
            autocmd FocusGained,BufEnter * :checktime
            autocmd FileChangedShellPost * echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None

            " Remove trailing white spaces. This is dangerous for some filetypes - like this one!
            autocmd BufWritePre *.py,*.bash,*.sh,*.vhd,*.csh,*.cpp,*.c silent! :call Trim_Whitespace()<CR>

            " Jump to last know position in a file (if the '" is set)
            autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | execute 'normal! g`"zvzz' | endif
            " :wautocmd BufNewFile *.vhd silent! execute '0r $my_OneDrive/Vim/templates/skeleton.vhd'

            " source vimrc after you save it
            autocmd BufWritePost init.vim nested source $MYVIMRC | call lightline#init()
            autocmd BufRead,BufNewFile *.inc set filetype=make

            autocmd BufLeave * :set nocursorcolumn | set nocursorline
            autocmd BufEnter * :set cursorcolumn | set cursorline

            autocmd BufNewFile * :set fileformat=unix

            autocmd ColorScheme * call colorscheme_mods#MyMonotone()
            "delete netrw buffers when they become hidden
            autocmd FileType netrw setl bufhidden=delete

        augroup END " }
    endif " has("autocmd")
" }}} Autocmd "
" Taglist {{{ "
   if has('nvim')
        " neovim doesn't support emacs style tags
        set tags=./vTAGS;/,vTAGS;/                  " search tags files efficiently
    else
        set tags=./TAGS;/,TAGS;/                  " search tags files efficiently
    endif
    set notagrelative                           " If tags file in another directory, filenames in that file are not relative (absolute)
    set noautochdir                             " always switch to the current file directory. Turning this off because of tags
" }}} Taglist "

"stop sourcing this file from clearing the rtp / packpath in windows. 
" stop guifonts from resizing the window

colorscheme monotone

let g:my_dont_reload = 1
