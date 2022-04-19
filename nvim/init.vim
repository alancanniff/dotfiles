" Assorted Setup and configuration {{{ "

    " K over keyword to goto help for it
    " :h keyword <c-d> brings up list of matching entries

    " instead of reinventing the wheel - you can use these to point to the standard config and cache
    " without explictily using $XDG_CONGIG_HOME / $XDG_CACHE_HOME
    " stdpath('config')
    " stdpath('cache')

    let g:is_windows = has('win32') || has('win64')

    if g:is_windows
        let g:python3_host_prog = 'c:/Windows/py.exe'
        " be expicit about this on windows as cygwin + quartus sets this to bash
        " set shell=cmd.exe
    endif

    set swapfile
    let dir_swap=stdpath('cache').'/swp'
    let &dir= dir_swap.'//,'

    set backup                                "enable backup.
    let dir_back=stdpath('cache').'/backup'
    let &backupdir=dir_back.'//,'

    set undofile
    let dir_undo=stdpath('cache').'/undo'
    let &undodir=dir_undo.'//,'

" }}} Assorted Setup and configuration

" Packges {{{ "

lua << EOF
require('_packer')
EOF

" }}} Packages

" Settings {{{ "
    filetype plugin indent on                   " this is also needed for UltiSnip
    syntax on                                   " turn on syntax highlighting

    set termguicolors
    set wildoptions =pum

    if &wildoptions == "pum"
        " cnoremap <up> <c-p>
        " cnoremap <down> <c-n>
        cnoremap <expr> <C-P> wildmenumode() ? "<C-P>" : "<Up>"
        cnoremap <expr> <C-N> wildmenumode() ? "<C-N>" : "<Down>"
    endif


    " set completeopt=menu,preview
    " set completeopt=menuone,noinsert   " Set completeopt to have a better completion experience
    " set completeopt=menuone,noinsert,noselect   " Set completeopt to have a better completion experience
    " set completeopt=menu,menuone,noselect       " from nvim-cmp
    set completeopt=menu,menuone,noselect
    " set spell
    set laststatus=2                            " always show the statusline in the last (bottom) window
    set cmdheight=2                             " set command window height to 2.
    set confirm                                 " Confirm instead of fail a command
    set showmatch                               " show matching brackets
    set shortmess=caAOstT                        " shortens messages to avoid 'press a key' prompt " stops swp file warnings. In windows using --remote-silent opening two files with warnings freezes vim
    set signcolumn=yes                          " always show the sign colum
    " set switchbuf=useopen,usetab                " better behavior for the quickfix window and :sb
    set pumheight=10                            " set max height of popupmenu
    "set wildmenu                                " better command line completion, shows a list of matches. using the pum menu in neovim
    set wildmode=longest:full,list:full         " complete to the longest common on the first tab and display all the options, then select the first on the next one
    set wildignore=*.swp,*.bak                  " ignore these file in the
    set title                                   " change the terminal's title
    set nowrap                                  " turn off line wrap
    set mouse=a                                 " enable the mouse always

    set cursorline                              " highlight current line
    set cursorcolumn                            " highlight current col

    set tabstop=4                               " The width of a hard tabstop measured in spaces
    set softtabstop=4                           " when hitting tab or backspace, how many spaces should a tab be (see expandtab)
    set shiftwidth=4                            " size of indent
    set expandtab                               " uses spaces instead of tab

    set virtualedit=all                         " move the cursor anywhere on the screen
    set history=10000                            " increase the history buffer
    set scrolloff=3                             " leave 3 lines when scolling
    set sidescrolloff=5                         " leave 5 columns when scrolling/
    set sidescroll=5                            " only scroll by 5 char, not a half page
    set visualbell                              " Use visual bell instead of beeping when doing something wrong
    set ignorecase                              " ignore case when searching.
    set smartcase                               " ignore case unless you use capitals in the search
    " set display=lastline                        " show as much as possible for the last command. @@@ indicates truncate
    set noinfercase                             " infer case in completionl
    set noshowmode                              " don't show the mode in the command line as it's in airline
    set foldmethod=marker                       " enable folding at option - markers
    set foldmarker={{{,}}}
    set foldnestmax=1
    set lazyredraw                              " Don't redraw while executing macros (good performance config) 
    set timeoutlen=3000
    " set fillchars=vert:\┃,fold:-
    set list
    set listchars=tab:▸\ ,trail:·,extends:>,precedes:<,nbsp:+
    set nonumber                                " show line numbers
    set relativenumber                        " line nubers are relative to the current one
    set numberwidth=5                           " We are good up to 99999 lines
    " set pastetoggle=<F12>
    " set mousemodel=popup

    "set diffopt-=internal
    " set diffopt+=algorithm:patience
    " algorithm:{text} Use the specified diff algorithm with the
    " internal diff engine. Currently supported 
    " algorithms are:
    " myers      the default algorithm
    " minimal    spend extra time to generate the smallest possible diff
    " patience   patience diff algorithm
    " histogram  histogram diff algorithm

" }}} Settings "

" Key Mappings {{{ "
   " :map {key sequence} returns the current assignment for the sequence

    " \\ \/ toggle forward and back slash on the current line
    nnoremap <silent> \/ :let tmp=@/<Bar>s:\\:/:ge<Bar>let @/=tmp<Bar>noh<CR>
    nnoremap <silent> \\ :let tmp=@/<Bar>s:/:\\:ge<Bar>let @/=tmp<Bar>noh<CR>
                  
    nnoremap  <SPACE>o moo<ESC>`o
    nnoremap  <SPACE>O moO<ESC>`o

    nnoremap <C-]> g<C-]>

    " change the behaviour of jump to last mark so ' gets me to the exact positio, and not just the line
    nnoremap  ' `
    nnoremap  ` '

    nnoremap  \cd :cd %:p:h<CR>|:pwd

    tnoremap <ESC> <C-\><C-n>
    tnoremap <C-w> <C-\><C-n><C-w>
    tnoremap <expr> <C-R> '<C-\><C-N>"'.nr2char(getchar()).'pi'

    " CTRL-U in insert mode deletes a lot.  break the undo sequnce of better undo
    inoremap <C-U> <C-G>u<C-U>

    " this function has been moved to the plugins dir
    nmap \h <Plug>Highlight_SynStack

    " Close a buffer and switching to another buffer, do not close the window, 
    " see https://goo.gl/Wd8yZJ
    nnoremap <silent> \d :bprevious <bar> bdelete #<CR>

    nnoremap \w :call my_utils#Trim_Whitespace()<CR>

    " Close location list or quickfix list if they are present,
    " see https://goo.gl/uXncnS
    nnoremap<silent> \x :windo lclose <bar> cclose<CR>


    nnoremap [q  :cprevious<Cr>
    nnoremap ]q  :cnext<Cr>
    nnoremap [Q  :cfirst<Cr>
    nnoremap ]Q  :clast<Cr>

    " Change the behaviour of the mouse to line up with everythign else....
    nnoremap <RightDrag> <Nop>
    nnoremap <RightRelease> <MiddleRelease>
    nnoremap <RightMouse> <MiddleMouse>

    inoremap <RightDrag> <Nop>
    inoremap <RightRelease> <MiddleRelease>
    inoremap <RightMouse> <MiddleMouse>

    map <LeftRelease> "*y



"" }}} Key Mappings "

" Autocmd {{{ "

    " group the commands so they are cleared when you re-source the vimrc file.
    augroup aug_general " {
        autocmd!

        " set the format options I want. always.
        autocmd FileType * setlocal formatoptions+=j formatoptions-=c formatoptions-=r formatoptions-=o
        "autocmd FileType erf :Hexmode

        " auto reload files with a warning message
        " https://unix.stackexchange.com/questions/149209/refresh-changed-content-of-file-opened-in-vim/383044#383044
        " autocmd FocusGained,BufEnter * :checktime
        autocmd FileChangedShellPost * echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None

        " Remove trailing white spaces. This is dangerous for some filetypes - like this one!
        autocmd BufWritePre *.v,*.sv,*.yaml,*.tcl,*.bash,*.sh,*.vhd, silent! :call my_utils#Trim_Whitespace()<CR>
        " autocmd FileType python nnoremap \f :0,$!yapf<Cr> :w<CR>

        " Jump to last know position in a file (if the '" is set)
        autocmd BufReadPost * if (&filetype != 'gitcommit') && line("'\"") > 0 && line("'\"") <= line("$") | execute 'normal! g`"zvzz' | endif

        " source vimrc after you save it
        autocmd BufWritePost init.vim nested source $MYVIMRC 
        autocmd BufRead,BufNewFile *.inc set filetype=make

        autocmd BufLeave *.vhd,*.vhdl, :setlocal isfname+=.

        autocmd BufLeave * :set nocursorcolumn | set nocursorline | set norelativenumber | set number
        autocmd BufEnter * :set cursorcolumn | set cursorline | set relativenumber | set nonumber

        "delete netrw buffers when they become hidden
        autocmd FileType netrw setl bufhidden=delete
        autocmd FileType dirvish setl bufhidden=delete

        " autocmd BufHidden * if &buftype ==# 'terminal'
        " autocmd TermClose * if !v:event.status | exe 'bdelete! '..expand('<abuf>') | endif
        " let running = jobwait([&channel], 0)[0] == -1

    augroup END " }

" }}} Autocmd "

" Taglist {{{ "
    set tags=./tags;/,tags;/                  " search tags files efficiently
    set notagrelative                           " If tags file in another directory, filenames in that file are not relative (absolute)
    set noautochdir                             " always switch to the current file directory. Turning this off because of tags
" }}} Taglist "

" colorscheme {{{ "
    augroup aug_colorscheme " {
        autocmd!
        autocmd ColorScheme monotone call my_utils#Monotone_Mods()
    augroup END " }

    " make sure the autocmd is set before configuring the colorscheme

    silent! colorscheme twotone
    " silent! colorscheme monotone
" }}} " colorscheme


function! TabMessage(cmd)
    redir => message
    silent execute a:cmd
    redir END
    if empty(message)
        echoerr "no output"
    else
        tabnew
        setlocal buftype=nofile bufhidden=wipe noswapfile nobuflisted nomodified
        silent put=message
    endif
endfunction

command! -nargs=+ -complete=command TabMessage call TabMessage(<q-args>)

