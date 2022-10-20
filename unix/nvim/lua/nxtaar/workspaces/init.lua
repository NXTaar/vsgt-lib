local sessions = require('sessions')
local workspaces = require('workspaces')
local telescope = require('telescope')
local create_file = require('nxtaar.utils.fs').create_file
local file_exists = require('nxtaar.utils.fs').file_exists

local HOME = os.getenv('HOME')

local exports = {}

local sessions_root = HOME .. '/.nvim/sessions/'
local workspaces_root = HOME .. '/.nvim/workspaces'

if vim.fn.isdirectory(sessions_root) == 0 then
    vim.fn.mkdir(sessions_root, "p")
    print("creating sessions folder")
end

if not file_exists(workspaces_root) then
    create_file(workspaces_root)
    print("creating workspaces file")
end

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

return exports
