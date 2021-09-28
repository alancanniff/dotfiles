if !exists("g:loaded_fzf") | finish | endif

" let g:fzf_history_dir = stdpath('cache').'/fzf-history'

augroup aug_fzf
    autocmd!
    autocmd  FileType fzf set laststatus=0 noshowmode noruler | autocmd BufLeave <buffer> set laststatus=2 showmode ruler
    autocmd  FileType fzf tnoremap <buffer> <ESC> <ESC>
augroup END " }

let g:fzf_layout = { 'down': '~40%' }

" let g:fzf_preview_window = ''
nnoremap  <space>f :Files<CR>
nnoremap  <space>b :Buffers<CR>
nnoremap  <space>L :Lines<CR>
nnoremap  <space>t :BTags<CR>
nnoremap  <space>h :History<CR>
nnoremap  <space>: :History:<CR>
nnoremap  <space>/ :History/<CR>

nnoremap  gb :Buffers<CR>

