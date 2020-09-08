if !exists('g:loaded_gutentags')
  finish
endif

let g:gutentags_file_list_command = {
                             \ 'markers': {
                                 \ '.git': 'git ls-files',
                                 \ '.hg': 'hg files',
                                 \ },
                             \ }



