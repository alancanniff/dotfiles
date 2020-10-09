if !exists("g:loaded_fzf") | finish | endif

" let g:fzf_history_dir = stdpath('cache').'/fzf-history'

augroup aug_fzf
    autocmd!
    autocmd  FileType fzf set laststatus=0 noshowmode noruler | autocmd BufLeave <buffer> set laststatus=2 showmode ruler
    autocmd  FileType fzf tnoremap <buffer> <ESC> <ESC>
augroup END " }

let g:fzf_layout = { 'down': '~40%' }

" let g:fzf_preview_window = ''
nnoremap  <SPACE>f :Files<CR>
nnoremap  <SPACE>l :BLines<CR>
nnoremap  <SPACE>L :Lines<CR>
nnoremap  <SPACE>t :BTags<CR>
nnoremap  <SPACE>h :History<CR>
nnoremap  <SPACE>: :History:<CR>
nnoremap  <SPACE>/ :History/<CR>


