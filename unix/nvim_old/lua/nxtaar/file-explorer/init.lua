local tree = require('nvim-tree')

tree.setup({
	hijack_cursor = true,
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
		number = true,
		relativenumber = true,
	},
	renderer = {
		icons = {
			glyphs = {
				default = '',
				folder = {
					arrow_open = '▼',
					arrow_closed = '▶',
				},
				git = {
					ignored = '',
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
