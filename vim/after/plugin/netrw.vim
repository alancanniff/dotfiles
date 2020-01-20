if !exists("g:loaded_netrwPlugin")
    finish
endif

" nnoremap - :e %:h<cr>
" let g:netrw_banner = 0
let g:netrw_preview   = 1
" let g:netrw_liststyle = 3
let g:netrw_winsize   = 30

" let g:netrw_silent = 1
" let g:netrw_cygwin= 0


if g:is_windows
    let g:netrw_scp_cmd = 'pscp.exe -i c:\Users\alan.canniff\.ssh\id_rsa.ppk -q'
endif

