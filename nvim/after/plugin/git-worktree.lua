local ok, telescope, worktree

ok, worktree = pcall(require, "git-worktree")

if not ok then
	return
end

ok, telescope = pcall(require, "telescope")
if not ok then
	return
end

-- local map = require("my").map
telescope.load_extension("git_worktree")
vim.keymap.set("n", "<Space>ws", telescope.extensions.git_worktree.git_worktrees)
vim.keymap.set("n", "<Space>wc", telescope.extensions.git_worktree.create_git_worktree)

-- op = Operations.Switch, Operations.Create, Operations.Delete
-- metadata = table of useful values (structure dependent on op)
--      Switch
--          path = path you switched to
--          prev_path = previous worktree path
--      Create
--          path = path where worktree created
--          branch = branch name
--          upstream = upstream remote name
--      Delete
--          path = path where worktree deleted

worktree.on_tree_change(function(op, metadata)
	if op == worktree.Operations.Switch then
		print("Switched from " .. metadata.prev_path .. " to " .. metadata.path)
	end
end)
