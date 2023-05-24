local telescope = require('telescope')
local neoclip = require('neoclip').setup
local actions = require('telescope.actions')
local get_existing_prompts = require('telescope.state').get_existing_prompts
local exports = {}

function exports.search_file()
	if not pcall(vim.cmd, 'Telescope git_files') then
		vim.cmd('Telescope find_files')
	end
end

function exports.toggle_buffer()
	local current = get_existing_prompts()[1]
	local active = type(current) == 'number'

	if active then
		actions.close(current)
	else
		vim.cmd('Telescope buffers theme=dropdown previewer=false')
	end
end

exports.keymaps = {
	search_file = ":lua require('nxtaar.indexing').search_file()<CR>",
	search_file_all = ':Telescope find_files<CR>',
	search_string = ':Telescope live_grep<CR>',
	buffer = ":lua require('nxtaar.indexing').toggle_buffer()<CR>",
	show_registers = ':Telescope neoclip<CR>',
	list_git_branches = ':Telescope git_branches theme=ivy previewer=false initial_mode=normal<CR>',
}

telescope.setup({
	pickers = {
		buffers = {
			mappings = {
				i = {
					['<C-d>'] = actions.delete_buffer,
				},
				n = {
					['d'] = actions.delete_buffer,
				},
			},
		},
	},
})
telescope.load_extension('neoclip')
telescope.load_extension('fzf')
neoclip()

return exports
