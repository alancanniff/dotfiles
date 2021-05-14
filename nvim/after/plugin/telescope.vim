
" " ag --nogroup --column --color
" lua <<EOF
"     require'telescope.builtin'.find_files{
"     find_command = { "ag", "--nogroup", "--column", "--color"  }
" }
" EOF

" finish

" nnoremap <SPACE>p <cmd>lua require'telescope.builtin'.git_files{}<CR>
" nnoremap <SPACE>p <cmd>lua require'telescope.builtin'.live_grep{find_command = { "ag", "--nogroup", "--column", "--color"} }<CR>
" nnoremap <SPACE>f <cmd>lua require'telescope.builtin'.find_files{}<CR>
" nnoremap <SPACE>h <cmd>lua require'telescope.builtin'.oldfiles{}<CR>
" nnoremap <silent> gr <cmd>lua require'telescope.builtin'.lsp_references{}<CR>
