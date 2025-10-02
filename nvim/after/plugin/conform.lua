ok, pkg = pcall(require, "conform")

if not ok then
	return
end

vim.api.nvim_create_user_command("FormatToggle", function(args)
	if args.bang then
		-- FormatDisable! will disable formatting globally
		vim.g.disable_autoformat = not vim.g.disable_autoformat
	else
		vim.b.disable_autoformat = not vim.b.disable_autoformat
	end
end, {
	desc = "Toggle autoformat enabled",
	bang = true,
})

vim.api.nvim_create_user_command("FormatDisable", function(args)
	if args.bang then
		-- FormatDisable! will disable formatting just for this buffer
		vim.b.disable_autoformat = true
	else
		vim.g.disable_autoformat = true
	end
end, {
	desc = "Disable autoformat-on-save",
	bang = true,
})

vim.api.nvim_create_user_command("FormatEnable", function()
	vim.b.disable_autoformat = false
	vim.g.disable_autoformat = false
end, {
	desc = "Re-enable autoformat-on-save",
})
