local a = require("async")
local loader = require("bottomline").loader
local message = require("bottomline").message

local uv = vim.loop

local exports = {}

local spawn = a.wrap(uv.spawn)

local function git(args)
	return a.wait(spawn("git", { args = args }))
end

local function update_flog()
	a.wait(function(f)
		vim.schedule(f)
	end)
	pcall(vim.fn["flog#populate_graph_buffer"])
end

exports.checkout_master = a.sync(function()
	vim.cmd("silent Git checkout master")

	local stop_fetch_loader = loader("Fetching")
	local fetch = git({ "fetch" })
	stop_fetch_loader()

	assert(fetch == 0, "'git fetch' was unsuccessfull, code: " .. fetch)

	local stop_pull_loader = loader("Pulling")
	local pull = git({ "pull", "-r" })
	stop_pull_loader()

	assert(pull == 0, "'git pull' was unsuccessfull, code: " .. pull)

	update_flog()
	message("Synced ", 3000)
end)

exports.open_tree = a.sync(function()
	vim.cmd("Flog -all")

	local stop_fetch_loader = loader("Fetching")
	local fetch = git({ "fetch" })
	stop_fetch_loader()

	assert(fetch == 0, "'git fetch' was unsuccessfull, code: " .. fetch)

	local stop_prune_loader = loader("Pruning remotes")
	local prune = git({ "remote", "prune", "origin" })
	stop_prune_loader()

	assert(prune == 0, "'git prune' was unsuccessfull, code: " .. prune)

	update_flog()
	message("Fresh tree %#lualine_x_filetype_DevIconTxt_normal#%#lualine_c_normal#", 3000)
end)

return exports
