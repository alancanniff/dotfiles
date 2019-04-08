 if !exists("g:loaded_lightline")
    finish
endif
 
" lightline {{{ "

    augroup aug_lightline
        autocmd!
        autocmd User NeomakeFinished nested call lightline#update()
        "autocmd CursorHold,BufWritePost * call s:whitespace_check()
    augroup END " }

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
        \       [ 'readonly', 'absolutepath', 'modified' ]
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
        \ 'tabline_separator': {
        \   'left': '',
        \   'right': '',
        \ },
        \ 'tabline_subseparator': {
        \   'left': '',
        \   'right': '',
        \ }, 
        \ 'separator': {
        \   'left': '',
        \   'right': '',
        \ },
        \ 'subseparator': {
        \   'left': '',
        \   'right': '',
        \ },
        \ 'tabline': {
        \   'left': [  ['tabs'  ]],
        \   'right':  [ ['close' ]],
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
    "    call LightlineWhitespace()
    "    call LightlineMixedIndent()
    "    call LightlineUnwantedTab()
    "    call lightline#update()
    endfunction

        
" }}} lightline "
