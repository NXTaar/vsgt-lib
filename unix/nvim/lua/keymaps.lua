local indexing_actions = require('indexing').keymaps
local code_completion_keymap = require('code-completion.keymaps').code_completion_keymap
local code_completion_actions = require('code-completion.keymaps').actions
local lsp_keymap = require('lsp.keymaps').lsp_keymap
local lsp_actions = require('lsp.keymaps').actions
local projects_actions = require('projects').actions
local git = require('git')

local keymap = vim.api.nvim_set_keymap

local opts = { noremap = true, silent = true }

local function cmd_cb(cmd)
	return function()
		vim.cmd(cmd)
	end
end

local function leader_keymap(config)
	local mode = config.mode or 'n'
	local options = config.cmd and { noremap = true, callback = cmd_cb(config.cmd) }
		or { noremap = true, callback = config.callbackj }

	keymap(mode, '<leader>' .. config.key, '', options)
end

-- Split-screen navigation
keymap('n', '<C-h>', '<C-w>h', opts)
keymap('n', '<C-j>', '<C-w>j', opts)
keymap('n', '<C-k>', '<C-w>k', opts)
keymap('n', '<C-l>', '<C-w>l', opts)

-- Space as leader key
keymap('', '<Space>', '<Nop>', opts)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- File save
keymap('i', '<C-s>', '<Esc>:w<CR>a', opts)
keymap('n', '<leader>wf', '>:Format|w<CR>', opts)

-- Buffers
keymap('n', '<leader>bo', ':%bd | e#<CR>', opts)
leader_keymap({ key = 'o', cmd = 'only' })

-- Version control
leader_keymap({ key = 'gcm', callback = git.checkout_master })
leader_keymap({ key = 'gtr', callback = git.open_tree })
keymap('n', '<leader>gp', ':Git pull -r', opts)
keymap('n', '<leader>gf', ':Git fetch|Git remote prune origin<CR>', opts)
keymap('n', '<leader>gbd', ':Git branch -D ', opts)
keymap('n', '<leader>gg', ':Git<CR><C-w>5-', opts)
keymap('n', '<leader>gbl', ':Git blame<CR>', opts)

-- Clean up SVG
keymap('n', '<leader>svg', ':silent !svgo --config ~/.svgo/config.js %<CR>', opts)

-- Quick lists
keymap('n', '<leader>cl', ':ccl<CR>', opts)

-- Insert --
-- Press jj (or Russian "оо") fast to enter
keymap('i', 'jj', '<ESC>l', opts)
keymap('i', 'оо', '<ESC>l', opts)

-- File Explorer
keymap('n', '<leader>e', ':NvimTreeToggle<CR> |:NvimTreeRefresh<CR>', opts)

-- Indexing
keymap('n', '<leader>f', indexing_actions.search_file, opts)
keymap('n', '<leader>F', indexing_actions.search_file_all, opts)
keymap('n', '<leader>bl', indexing_actions.buffer, opts)
keymap('n', '<leader>lg', indexing_actions.search_string, opts)
keymap('n', '<leader>p', indexing_actions.show_registers, opts)
keymap('n', '<leader>gcb', indexing_actions.list_git_branches, opts)

-- Workspaces
keymap('n', '<leader>ws', projects_actions.show_workspaces, opts)

-- Sourcing files
keymap('n', '<leader>sc', ":source % | echo 'File '.expand('%').' sourced successfully'<CR>", opts)

-- Code completion
code_completion_keymap('<C-k>', code_completion_actions.select_prev_item)
code_completion_keymap('<C-j>', code_completion_actions.select_next_item)
code_completion_keymap('<C-b>', code_completion_actions.scroll_docs_up)
code_completion_keymap('<C-f>', code_completion_actions.scroll_docs_down)
code_completion_keymap('<C-y>', code_completion_actions.disable)
code_completion_keymap('<C-e>', code_completion_actions.close)
code_completion_keymap('<CR>', code_completion_actions.confirm)
code_completion_keymap('<Tab>', code_completion_actions.smart_select_next)
code_completion_keymap('<S-Tab>', code_completion_actions.smart_select_prev)

-- Language Server Protocol
lsp_keymap('n', 'gD', lsp_actions.goto_declaration)
lsp_keymap('n', 'gd', lsp_actions.goto_definition)
lsp_keymap('n', 'K', lsp_actions.hover)
lsp_keymap('n', 'gi', lsp_actions.goto_implementation)
lsp_keymap('n', '<C-k>', lsp_actions.signature_help)
lsp_keymap('n', '<leader>rn', lsp_actions.rename)
lsp_keymap('n', 'gr', lsp_actions.show_references)
lsp_keymap('n', '<leader>x', lsp_actions.code_action)
lsp_keymap('n', '<leader>i', lsp_actions.open_float)
lsp_keymap('n', '[d', lsp_actions.goto_prev_diagnostics)
lsp_keymap('n', 'gl', lsp_actions.show_line_diagnostics)
lsp_keymap('n', ']d', lsp_actions.goto_next_diagnostics)
lsp_keymap('n', '<leader>lloc', lsp_actions.set_loc_list)
