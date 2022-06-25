local telescope = require("telescope")
local neoclip = require("neoclip").setup
local actions = require("telescope.actions")
local get_existing_prompts = require("telescope.state").get_existing_prompts
local exports = {}

function exports.plugin(use)
	use({
		"nvim-telescope/telescope.nvim",
		requires = { { "nvim-lua/plenary.nvim" } },
	})
	use({
		"nvim-telescope/telescope-fzf-native.nvim",
		run = "make",
	})
	use({
		"AckslD/nvim-neoclip.lua",
		requires = {
			{ "nvim-telescope/telescope.nvim" },
		},
	})
end

function exports.init()
    telescope.setup({
		pickers = {
			buffers = {
				mappings = {
					i = {
						["<C-d>"] = actions.delete_buffer,
					},
					n = {
						["d"] = actions.delete_buffer,
					},
				},
			},
		},
	})
    telescope.load_extension('neoclip')
    telescope.load_extension('fzf')
    neoclip()
end

function exports.search_file()
	if not pcall(vim.cmd, "Telescope git_files") then
		vim.cmd("Telescope find_files")
	end
end

function exports.toggle_buffer()
	local current = get_existing_prompts()[1]
	local active = type(current) == "number"

	if active then
		actions.close(current)
	else
		vim.cmd("Telescope buffers theme=dropdown previewer=false")
	end
end

exports.keymaps = {
	search_file = ":lua require('indexing').search_file()<CR>",
	search_file_all = ":Telescope find_files<CR>",
    search_string = ":Telescope live_grep<CR>",
	buffer = ":lua require('indexing').toggle_buffer()<CR>",
    show_registers = ":Telescope neoclip<CR>",
    list_git_branches = ":Telescope git_branches theme=ivy previewer=false initial_mode=normal<CR>",
}

return exports
