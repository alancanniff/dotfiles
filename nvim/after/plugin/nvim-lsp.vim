if !exists('g:nvim_lsp')
  finish
endif

"  
"
" lua require'nvim_lsp'.pyls.setup{}
lua require'nvim_lsp'.clangd.setup{}
" lua require'nvim_lsp'.vhdl.setup{}
" " lua require'nvim_lsp'.vimls.setup{}
" " lua require'nvim_lsp'.yamlls.setup{}

" " autocmd Filetype vim setlocal omnifunc=v:lua.vim.lsp.omnifunc
" autocmd Filetype python setlocal omnifunc=v:lua.vim.lsp.omnifunc
" " autocmd Filetype vhdl setlocal omnifunc=v:lua.vim.lsp.omnifunc
" autocmd Filetype cpp setlocal omnifunc=v:lua.vim.lsp.omnifunc
autocmd Filetype c setlocal omnifunc=v:lua.vim.lsp.omnifunc
" autocmd Filetype vhdl setlocal omnifunc=v:lua.vim.lsp.omnifunc
" " autocmd Filetype sh setlocal omnifunc=v:lua.vim.lsp.omnifunc
" " autocmd Filetype yaml setlocal omnifunc=v:lua.vim.lsp.omnifunc | setlocal completeopt=menuone,noselect

nnoremap <silent> gd    <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> <c-]> <cmd>lua vim.lsp.buf.definition()<CR>
" nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>

" command! Format lua vim.lsp.buf.formatting()<CR>
" nnoremap <silent> \f    :Format<CR>



