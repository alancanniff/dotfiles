if !exists("g:asynctasks_system") | finish | endif

noremap <silent><f5> :AsyncTask file-run<cr>
noremap <silent><f9> :AsyncTask file-build<cr>
let g:asyncrun_open = 5
let g:asynctasks_term_pos = 'bottom'
let g:asynctasks_term_reuse = 1
let g:asynctasks_extra_config = [stdpath('config').'/nvim/asynctasks.ini']

