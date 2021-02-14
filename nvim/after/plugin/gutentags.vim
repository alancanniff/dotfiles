if !exists('g:loaded_gutentags')
  finish
endif


let g:gutentags_add_ctrlp_root_markers = 0

let g:gutentags_file_list_command = { 'markers': { '.git': 'git ls-files', }, }
" let g:gutentags_ctags_executable = 'universal-ctags'
let g:gutentags_trace = 0
