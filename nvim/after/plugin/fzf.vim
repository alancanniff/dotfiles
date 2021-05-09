if !exists("g:loaded_fzf") | finish | endif

" let g:fzf_history_dir = stdpath('cache').'/fzf-history'

augroup aug_fzf
    autocmd!
    autocmd  FileType fzf set laststatus=0 noshowmode noruler | autocmd BufLeave <buffer> set laststatus=2 showmode ruler
    autocmd  FileType fzf tnoremap <buffer> <ESC> <ESC>
augroup END " }

let g:fzf_layout = { 'down': '~40%' }

" let g:fzf_preview_window = ''
nnoremap  <leader>f :Files<CR>
nnoremap  <leader>l :BLines<CR>
nnoremap  <leader>L :Lines<CR>
nnoremap  <leader>t :BTags<CR>
nnoremap  <leader>h :History<CR>
nnoremap  <leader>: :History:<CR>
nnoremap  <leader>/ :History/<CR>


