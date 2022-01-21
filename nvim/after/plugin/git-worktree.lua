local ok, worktree = pcall(require, 'git-worktree')
if not ok then 
    return 
end

local ok, telescope = pcall(require, 'telescope')
if not ok then 
    return 
end

local map = require('my').map
require("telescope").load_extension("git_worktree")
map('n', '<Space>ws', [[:lua require('telescope').extensions.git_worktree.git_worktrees()<Cr>]])      
map('n', '<Space>wc', [[:lua require('telescope').extensions.git_worktree.create_git_worktree()<Cr>]])

---- "" Example of custom completion function
---- " :com -complete=custom,ListUsers -nargs=1 Finger !finger <args>
---- " :fun ListUsers(A,L,P)
---- " :    return system("cut -d: -f1 /etc/passwd")
---- " :endfun
----    " " Call a user function (example of <f-args>)
----    " :com -nargs=* Mycmd call Myfunc(<f-args>)
---- 
---- " When executed as: >
---- 	" :Mycmd arg1 arg2
---- " This will invoke: >
---- 	" :call Myfunc("arg1","arg2")
---- 
---- " command! -bang -nargs=* FzfRgNoIgnore call fzf#vim#grep("rg --no-ignore --column --line-number --no-heading --color=always --smart-case -- ".shellescape(<q-args>), 1, fzf#vim#with_preview(), <bang>0)
---- " command! -bang -nargs=* 
---- " lua require("git-worktree").create_worktree("feature/150-update_petalinux_cache_settings", "feature/150-update_petalinux_cache_settings", "origin")
---- " lua require("git-worktree").switch_worktree("feature/150-update_petalinux_cache_settings", "feature/150-update_petalinux_cache_settings", "origin")
---- " lua require("git-worktree").delete_worktree("feature/150-update_petalinux_cache_settings", "feature/150-update_petalinux_cache_settings", "origin")
---- nnoremap <Space>wc :lua require('telescope').extensions.git_worktree.git_worktrees()<Cr>
---- nnoremap <Space>ws :lua require('telescope').extensions.git_worktree.create_git_worktree()<Cr>
---- 
