if !exists("g:loaded_fzf")
    finish
endif

" let g:fzf_history_dir = g:my_cache_vim.'/fzf-history'

augroup aug_fzf
    autocmd!
    autocmd  FileType fzf set laststatus=0 noshowmode noruler
      \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler
augroup END " }


