local HOME = os.getenv("HOME")

local exports = {}

local sessions_root = HOME .. "/.nvim/sessions/"
local workspaces_root = HOME .. "/.nvim/workspaces"

exports.actions = {
	show_workspaces = ":Telescope workspaces initial_mode=normal theme=dropdown<CR>",
}

function exports.load_workspace_session()
	print("load session here")
end

local function init(project_config, sessions, workspaces, telescope)
	project_config.setup()

	workspaces.setup({
		path = workspaces_root,
		hooks = {
            open_pre = function ()
				sessions.stop_autosave({ save = true })
				vim.cmd("bufdo bd!")
            end,
			open = function(name)
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
		events = { "VimLeavePre", "BufEnter" },
	})

	telescope.load_extension("workspaces")

	vim.cmd([[
        augroup load_workspace_session
            autocmd! *
            autocmd VimEnter * lua require('projects').load_workspace_session()
        augroup END
    ]])
end

require("dependencies").module(
	{ "nvim-projectconfig", "sessions", "workspaces", "telescope" },
	{ "windwp/nvim-projectconfig", "natecraddock/workspaces.nvim", "natecraddock/sessions.nvim" },
	init
)

return exports
