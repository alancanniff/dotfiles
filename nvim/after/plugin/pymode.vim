if !exists("g:pymode")
    finish
endif

let g:pymode_options_max_line_length = 119
let g:pymode_python = 'python3'
let g:pymode_lint_checkers += ['pylint', 'flake8']
let g:pymode_lint_options_pep8 = {'max_line_length': g:pymode_options_max_line_length}
let g:pymode_lint_options_pylint = {'max-line-length': g:pymode_options_max_line_length}

