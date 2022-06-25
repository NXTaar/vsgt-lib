local HOME = os.getenv('HOME')

local exports = {}

local sessions_root = HOME .. '/.nvim/sessions/'

-- local events = require('events').list
-- vim.api.nvim_create_autocmd(events, {
-- 	pattern = '*',
-- 	callback = function(data)
-- 		print('Event fired: ' .. data.event)
-- 	end,
-- })

-- vim.cmd("source "..sessions_root..'json-cms-service')

-- exports.actions = {
-- 	show_workspaces = '<CR>',
-- }

-- return exports

local workspaces_root = HOME .. '/.nvim/workspaces'

exports.actions = {
	show_workspaces = ':Telescope workspaces initial_mode=normal theme=dropdown<CR>',
}

local function load_workspace_session(ws)
	local workspaces = {}
	local pwd = vim.fn.getcwd()

	for _, workspace in ipairs(ws.get()) do
		local name = workspace.name
		local path = workspace.path

		workspaces[path] = name
	end

	local workspace = workspaces[pwd:gsub('/?$', '/')]

	if not workspace then
		return
	end

	ws.open(workspace)
	vim.schedule(function()
		vim.cmd('doautoall BufRead')
	end)
end

local function init(project_config, sessions, workspaces, telescope)
	project_config.setup()

	workspaces.setup({
		path = workspaces_root,
		hooks = {
			open_pre = function()
				sessions.stop_autosave({ save = true })
				vim.cmd('bufdo bd!')
			end,
			open = function(name)
				print('opening workspace: ' .. name)
				local loaded = sessions.load(sessions_root .. name, { silent = true })

				if not loaded then
					sessions.save(sessions_root .. name)
				end
			end,
			add = function(name)
				sessions.save(sessions_root .. name)
			end,
		},
	})
	sessions.setup({
		events = { 'VimLeavePre', 'BufEnter' },
	})

	telescope.load_extension('workspaces')

	load_workspace_session(workspaces)
end

require('dependencies').module(
	{ 'nvim-projectconfig', 'sessions', 'workspaces', 'telescope' },
	{ 'windwp/nvim-projectconfig', 'natecraddock/workspaces.nvim', 'natecraddock/sessions.nvim' },
	init
)

return exports
