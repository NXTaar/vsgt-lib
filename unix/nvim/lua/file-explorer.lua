local status_ok, tree = pcall(require, "nvim-tree")
if not status_ok then
	return
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
