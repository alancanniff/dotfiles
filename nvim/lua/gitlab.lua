local curl = require("plenary.curl")
local notify = require("notify")

-- local notify = require("notify")
-- local json = vim.json.decode(result["body"])

-- local s = {}
-- for _, job in ipairs(json) do
-- 	if job["status"] == "running" then
-- 		notify.notify(vim.inspect(job), vim.log.levels.INFO, { title = "running" })
-- 		for k, v in pairs(job) do
-- 			table.insert(s, string.format("%s: %s", k, v))
-- 		end
-- 		table.insert(s, "")
-- 	end
-- end

-- vim.api.nvim_command("botright vnew")
-- local buf = vim.api.nvim_get_current_buf()

-- vim.api.nvim_buf_set_name(0, "Testing gitlab")

-- vim.opt_local.buftype = "nofile"
-- vim.opt_local.swapfile = false
-- vim.opt_local.bufhidden = "wipe"
-- vim.api.nvim_buf_set_lines(buf, 0, -1, false, s)

local M = {}

-- id: 562973847

M.get_job_json = function(id)
	-- project id for foam
	local project_id = 28611950
	local url = "https://gitlab.com/api/v4/projects/" .. project_id .. "/pipelines/" .. id
	local token_header = "PRIVATE-TOKEN: " .. vim.fn.expand("$GITLAB_TOKEN")

	local res = curl.request({
		url = url,
		raw = { "--header", token_header },
	})

	-- return vim.json.decode(res["body"])
	return res
end

M.get_jobs_json = function()
	-- project id for foam
	local project_id = 28611950
	local url = "https://gitlab.com/api/v4/projects/" .. project_id .. "/pipelines"
	local token_header = "PRIVATE-TOKEN: " .. vim.fn.expand("$GITLAB_TOKEN")

	local res = curl.request({
		url = url,
		raw = { "--header", token_header },
	})

	-- return vim.json.decode(res["body"])
	return res
end

M.check_later = function(id, opt)
	-- Create a timer to check the build status in 10 seconds
	local timer = vim.loop.new_timer()
	print("Setting tinmer")

	timer:start(
		10000,
		0,
		vim.schedule_wrap(function()
			local result = M.get_job_json(id)
			if result["exit"] ~= 0 then
				return
			end
			local job = vim.json.decode(result["body"])
			if job["status"] == "success" then
				notify.notify(vim.inspect(job), vim.log.levels.INFO, { title = "Success" })
			end
		end)
	)
end

M.report_jobs = function()
	local result = M.get_jobs_json()
	if result["exit"] ~= 0 then
		return
	end
	local json = vim.json.decode(result["body"])

	local s = {}
	for _, job in ipairs(json) do
		if job["status"] == "success" and job["ref"] == "master" then
			-- notify.notify(vim.inspect(job), vim.log.levels.INFO, { title = "running" })

			M.check_later(job["id"])

			for k, v in pairs(job) do
				table.insert(s, string.format("%s: %s", k, v))
			end
			table.insert(s, "")
		end
	end

	vim.api.nvim_command("botright vnew")
	local buf = vim.api.nvim_get_current_buf()

	vim.api.nvim_buf_set_name(0, "Testing gitlab")

	vim.opt_local.buftype = "nofile"
	vim.opt_local.swapfile = false
	vim.opt_local.bufhidden = "wipe"
	vim.api.nvim_buf_set_lines(buf, 0, -1, false, s)
end

return M
