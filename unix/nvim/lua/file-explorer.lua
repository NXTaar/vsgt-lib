local status_ok, tree = pcall(require, "nvim-tree")
if not status_ok then
	return
end

local change_dir = require("nvim-tree.actions.change-dir")
local pwd = vim.fn.getcwd()

local function reset_cwd()
	change_dir.fn(pwd)
end

tree.setup({
	hijack_cursor = true,
	auto_close = true,
	update_cwd = true,
	update_focused_file = {
		enable = true,
	},
	git = {
		ignore = false,
	},
	view = {
		adaptive_size = true,
		centralize_selection = true,
		mappings = {
			custom_only = false,
			list = {
				{ key = "_", action = "reset_cwd", action_cb = reset_cwd },
			},
		},
		number = true,
		relativenumber = true,
	},
	renderer = {
		icons = {
			glyphs = {
				default = "",
				folder = {
					arrow_open = "▼",
					arrow_closed = "▶",
				},
				git = {
					ignored = "",
				},
			},
		},
		indent_markers = {
			enable = true,
		},
	},
	actions = {
		open_file = {
			quit_on_open = true,
		},
	},
})
