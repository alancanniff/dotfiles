if !exists("g:asynctasks_system") | finish | endif

noremap <silent><f4> :AsyncTask file-build<cr>
noremap <silent><f5> :AsyncTask file-run<cr>
noremap <silent><f6> :AsyncTask fpga-sim<cr>
noremap <silent><f7> :AsyncTask fpga-build<cr>
noremap <silent><f8> :AsyncTask petalinux-build<cr>
noremap <silent><f9> :AsyncTask file-build<cr>

let g:asyncrun_open = 6
let g:asynctasks_term_rows = 20
let g:asynctasks_term_pos = 'bottom'
let g:asynctasks_term_reuse = 1
let g:asynctasks_extra_config = [stdpath('config').'/.asynctask']
if g:is_windows
    let g:asynctasks_system = 'windows'
else
    let g:asynctasks_system = 'linux'
endif

if !exists("g:loaded_fzf") | finish | endif

function! s:fzf_sink(what)
	let p1 = stridx(a:what, '<')
	if p1 >= 0
		let name = strpart(a:what, 0, p1)
		let name = substitute(name, '^\s*\(.\{-}\)\s*$', '\1', '')
		if name != ''
			exec "AsyncTask ". fnameescape(name)
		endif
	endif
endfunction

function! s:fzf_task()
	let rows = asynctasks#source(&columns * 48 / 100)
	let source = []
	for row in rows
		let name = row[0]
		let source += [name . '  ' . row[1] . '  : ' . row[2]]
	endfor
	let opts = { 'source': source, 'sink': function('s:fzf_sink'),
				\ 'options': '+m --nth 1 --inline-info --tac' }
	if exists('g:fzf_layout')
		for key in keys(g:fzf_layout)
			let opts[key] = deepcopy(g:fzf_layout[key])
		endfor
	endif
	call fzf#run(opts)
endfunction

command! -nargs=0 FzfAsyncTask call s:fzf_task()
noremap <silent><Space>at :FzfAsyncTask <CR>

