local telescope = require('telescope.builtin')
local themes = require('telescope.themes')
local register_action = require('nxtaar.actions').register_action

register_action('telescope.show-references', function()
    telescope.lsp_references(themes.get_ivy({ initial_mode = 'normal' }))
end)
