" <c-k> over keyword to goto help for it
" :h keyword <c-d> brings up list of matching entries
" zc close a fold under cursor
" zM close all
" zR open all
" I've started moving things into plugin directories. 
"       " :scriptnames to see what's been loaded

set guioptions+=M                          " M = don't load menu. has to be run before other options which is why it's done here. See help
if has('nvim')
    let g:python_host_prog = 'c:/Python27/python.exe'
    let g:python3_host_prog = 'c:/Python37/python.exe'
endif
" Functions {{{ "

function! Make_Directory(path)
    if !isdirectory(a:path)
        call mkdir(a:path, "p", 0700)
    endif
endfunction
"
" remove the underline from the statusline
function! MonotoneMods() abort
    if exists("g:colors_name")
        if g:colors_name =~? 'monotone'
            highlight statusline cterm=none
            highlight statusline ctermbg=236
            highlight statusline gui=none
            highlight statusline guibg=#303030
            highlight statuslinenc cterm=none
            highlight statuslinenc ctermbg=236
            highlight statuslinenc gui=none
            highlight statuslinenc guibg=#303030
            " make the vert split and statusline a unified color, different from background
            highlight vertsplit guibg=#303030
            highlight vertsplit guifg=#303030
            highlight vertsplit ctermbg=236
            highlight vertsplit ctermfg=236
            " change the color of the cursor columns
            highlight CursorColumn guibg=grey20
            highlight CursorLine guibg=grey20
            highlight CursorColumn ctermbg=235
            highlight CursorLine ctermbg=235
        endif
    endif
endfunction


" }}} Functions "
" Directory and rtp config {{{ "

    let windows = has('win32') || has('win64')
    let unix    = has('unix')

    " convert all back slashes to forward slashes
    let g:my_config_home = substitute($HOME.'/.config', '\', '/', 'g')
    let g:my_cache_home = substitute($HOME.'/.cache', '\', '/', 'g')

    let g:my_config_vim = g:my_config_home.'/vim'
    call Make_Directory(g:my_config_vim)

    let g:my_cache_vim = g:my_cache_home.'/vim'

    if !exists("g:my_dont_reload") 
        " don't reload when this file is saved as it breaks the plugins by clearing them from the rtp
        " in windows call a file '.vimrc.' to create .vimrc - .vim. to get .vim directory
        " the & indicates the let is setting a setting, not a variable
        " let &runtimepath=g:my_config_vim.",$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,".g:my_config_vim."/after"
        " let &packpath = &runtimepath

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
" Packages -- minpac {{{ "

    function! PackInit() abort
        packadd minpac
        call minpac#init()
        call minpac#add('k-takata/minpac', {'type':'opt'})      " let minpac manage itself
        call minpac#add('python-mode/python-mode', {'type':'opt'})
        call minpac#add('tpope/vim-vinegar')                    " basic directory tree navigation plug in
        call minpac#add('tpope/vim-surround')                   " for swapping around braces: change - cs([, delete - ds(, added - ysiw(
        call minpac#add('tpope/vim-fugitive')
        "call minpac#add('tpope/vim-unimpaired')
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
        " colorschemes
        call minpac#add('https://gitlab.com/ducktape/monotone-termnial.git')
        call minpac#add('Lokaltog/vim-monotone')
    endfunction

    command! PackUpdate call PackInit() | call minpac#update('', {'do': 'call minpac#status()'})
    command! PackClean  call PackInit() | call minpac#clean()
    command! PackStatus call PackInit() | call minpac#status()

" }}} Packages -- minpac "
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
        set guifont=Consolas_NF:h11:cANSI:qDRAFT,Consolas:h11 " Consolas_NF is the powerline font
    "    set guifont=Anonymice_Powerline:h11:cANSI:qDRAFT
    endif

    if !has('nvim')
        let &viminfofile=g:my_cache_vim.'/viminfo'
    endif

    set sessionoptions+=slash                   " covert all paths to use /
    set backspace=indent,eol,start              " let the backspace key work normally
    set hidden                                  " hide unsaved buffers
    set autoread                                " auto read file when changed outside of buffer
    set laststatus=2                            " always show the statusline in the last (bottom) window
    set cmdheight=2                             " set command window height to 2.
    set confirm                                 " Confirm instead of fail a command
    set showmatch                               " show matching brackets
    set autochdir                               " always switch to the current file directory.. Messes with some plugins, but I like it
    set shortmess=aAOstT                        " shortens messages to avoid 'press a key' prompt " stops swp file warnings. In windows using --remote-silent opening two files with warnings freezes vim
    set switchbuf=useopen,usetab                " better behavior for the quickfix window and :sb
    set wildmenu                                " better command line completion, shows a list of matches
    set wildignore=*.swp,*.bak                  " ignore these file in the
    "set title                                   " change the terminal's title
    set nowrap                                  " turn off line wrap
    set textwidth=0                             " stop line breaks when writing.
    set mouse=                                  " going to play with gvim. Turn off mouse. It's too tempting.
    set formatoptions-=c                        " Auto-wrap comments using textwidth, inserting the current comment leader automatically.
    set formatoptions-=r                        " Automatically insert the current comment leader after hitting <Enter> in Insert mode.
    set formatoptions-=o                        " Automatically insert the current comment leader after hitting 'o' or 'O' in Normal mode.
    set formatoptions+=j                        " Delete comment character when joining commented lines
    set guioptions+=c                           " 'c'   Use console dialogs instead of popup dialogs for simple choices.
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
    "set omnifunc                                " enable completion <c-x><c-o> 

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
" Statusline {{{  "

    " set ruler                                   " show the ruler 
    " set statusline=                             " clear the statusline for when vimrc is reloaded
    " set statusline+=%f\                         " file name
    " set statusline+=%h%m%r%w                    " flags
    " set statusline+=[%{strlen(&ft)?&ft:'none'}, " filetype
    " set statusline+=%{&fileformat}]             " file format
    " set statusline+=%=
    " set statusline+=%10((%l/%L,%c)%)\           " line and column
    " set statusline+=%P\                         " percentage of file
    " hi StatusLine gui=NONE
    " hi StatusLineNC gui=NONE
    " '%<${ repeat("─", winwidth(0)) }>'
    "https://github.com/ralismark/vimfiles
    "let &statusline = '%f%h%m%r%w '. repeat("\u2014", winwidth(0)-40) 

" }}} Statusline "
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

    " remove last search highlighting -- taken from tpopes vim-sensible
    if maparg('<C-L>', 'n') ==# ''
        nnoremap <silent> <C-L> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>
    endif
    nnoremap  :simalt ~x

    " Y yanks to end of line, line D and C (not like yy)
    map Y y$

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

            " For all text files set 'textwidth' to 78 characters.
            " autocmd FileType text setlocal textwidth=78

            " AUTOCOMMAND

            " auto reload files with a warning message
            " https://unix.stackexchange.com/questions/149209/refresh-changed-content-of-file-opened-in-vim/383044#383044
            " try do something about the dialog box in gvim
            autocmd FocusGained,BufEnter * :checktime
            autocmd FileChangedShellPost * echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None

            " Remove trailing white spaces. This is dangerous for some filetypes - like this one!
            " autocmd BufWritePre *.vhd,*.csh,*.cpp,*.c silent! :call Trim_Whitespace()<CR>

            " Jump to last know position in a file (if the '" is set)
            autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | execute 'normal! g`"zvzz' | endif
            " :wautocmd BufNewFile *.vhd silent! execute '0r $my_OneDrive/Vim/templates/skeleton.vhd'

            " source vimrc after you save it
            autocmd BufWritePost init.vim nested source $MYVIMRC | call lightline#init()

            if has("gui_running")
                " kill the alarm bell
                autocmd GUIEnter * set visualbell t_vb=
                " start the gui maximized
                if windows
                    autocmd GUIEnter * simalt ~x
                endif
            endif

            autocmd BufLeave * :set nocursorcolumn | set nocursorline
            autocmd BufEnter * :set cursorcolumn | set cursorline

            autocmd ColorScheme * call MonotoneMods()

        augroup END " }
    endif " has("autocmd")
" }}} Autocmd "
" Taglist {{{ "
    " ok so ctags needs to be installed - chocolatey  has it if windows.
    " ctags needs to be runs in the directory you want to index  'ctags -R .'
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
" }}} Taglist "
" Ultisnips {{{ "
    let g:my_config_ultisnips = g:my_config_vim.'/UltiSnips'
    call Make_Directory(g:my_config_ultisnips)

    let g:UltiSnipsExpandTrigger="<tab>"                    " this is the default - tab expands snippet (<c-j> goes to next field
    let g:UltiSnipsSnippetsDir=g:my_config_ultisnips
    "let g:UltiSnipsSnippetDirectories=["UltiSnips", "mycoolsnippets"]
    "let g:UltiSnipsSnippetsDir= join([g:my_config_home, "UltiSnips"], '/')     " ultisnips didn't like using string concatonation in this global 
    let g:UltiSnipsEditSplit="horizontal"                   " show this snippet file in a horizontal split
" }}} Ultisnips "
" vimwiki {{{ "
    let g:vimwiki_list = [ {'path': g:my_config_home.'/vimwiki'} ]
" }}} vimwiki "
" lightline {{{ "
    " component_expand allows different color for neomake. see help
    let g:lightline = {
        \ 'mode_map' : {
        \   'n' : 'N',
        \   'i' : 'I',
        \   'R' : 'R',
        \   'v' : 'V',
        \   'V' : 'VL',
        \   "\<C-v>": 'VB',
        \   'c' : 'C',
        \   's' : 'S',
        \   'S' : 'SL',
        \   "\<C-s>": 'SB',
        \   't': 'T',
        \ },
        \ 'inactive' : {
        \   'left': [ 
        \       [ 'absolutepath'] 
        \   ],
        \   'right': [ ],
        \ },
        \ 'active': {
        \   'left'  : [
        \       [ 'mode', 'paste' ],
        \       [  'fugitive' ],
        \       [ 'readonly', 'filename', 'modified' ]
        \   ],
        \   'right' : [
        \       ['neomake',  'lineinfo'],
        \       ['mixedindent',  'unwantedtab', 'whitespace'],
        \       ['fileformat', 'fileencoding', 'filetype'],
        \   ],
        \ },
        \ 'component': {
        \   'lineinfo': '%3l:%-2v',
        \ },
        \ 'component_expand': {
        \   'neomake' : 'LightlineNeomake',
        \   'mixedindent' : 'LightlineMixedIndent',
        \   'unwantedtab' : 'LightlineUnwantedTab',
        \   'whitespace' : 'LightlineWhitespace',
        \ },
        \ 'component_function': {
        \   'readonly': 'LightlineReadonly',
        \   'fugitive': 'LightlineFugitive',
        \ },
        \ 'component_type': {
        \   'neomake': 'error',
        \   'mixedindent': 'error',
        \   'unwantedtab': 'error',
        \   'whitespace': 'warning',
        \ },
        \ 'separator': {
        \   'left': '',
        \   'right': '',
        \ },
        \ 'subseparator': {
        \   'left': '',
        \   'right': '', 
        \ }
    \ }
 
    function! LightlineNeomake() abort
        let stats = []
        let lcounts = neomake#statusline#LoclistCounts()
        for key in sort(keys(lcounts))
            call add(stats, printf( '%s: %d', key, lcounts[key]))
        endfor
        return join(stats, ' ')
    endfunction

    augroup aug_lightline
        autocmd!
        autocmd User NeomakeFinished nested call lightline#update()
        autocmd CursorHold,BufWritePost * call s:whitespace_check()
    augroup END " }

    function! LightlineReadonly()
        return &readonly ? '' : ''
    endfunction

    " !~? -- doesn't regex and ignores case
    function! LightlineFugitive()
        if &ft !~? 'help\|vimfiler' && exists('*fugitive#head')
            let branch = fugitive#head()
            return branch !=# '' ? ' '.branch : ''
        endif
        return ''
    endfunction

    function! LightlineUnwantedTab() abort
        if &expandtab
            if &ft !~? 'help'
                let tabs = search('\t', 'nw')
                return tabs == '0' ? '' : '▸'.tabs
            endif
        endif
        return ''
    endfunction

    " https://github.com/vim-airline/vim-airline/blob/master/autoload/airline/extensions/whitespace.vim
    function! LightlineMixedIndent() abort
        " check if there is mixed indentingin the file. Use the value of expandtab to return the tab or space line
        if &ft !~? 'help'
            let tabs = search('^\t', 'nw')
            let spaces = search('^ ', 'nw')
            if (tabs > 0) && (spaces > 0)
            return &expandtab == '0' ? '▸┅'.spaces : '┅▸'.tabs
            endif
        endif
        return ''
    endfunction

    " checks for trailing whiite spaces in selected filetypes
    " returns line number
    function! LightlineWhitespace() abort
        if &ft !~? 'help\|vim'
            let replace = search(' \+$', 'wn')
            return replace == '0' ? '' : '┅'.replace
        endif
        return ''
    endfunction

    function! s:whitespace_check()
        call LightlineWhitespace()
        call LightlineMixedIndent()
        call LightlineUnwantedTab()
        call lightline#update()
    endfunction

        
" }}} lightline "
" quick-scope {{{ "
    let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']
    " see after/plugins
" }}} quick-scope "

"stop sourcing this file from clearing the rtp / packpath in windows. 
" stop guifonts from resizing the window
colorscheme monotone
let g:my_dont_reload = 1
