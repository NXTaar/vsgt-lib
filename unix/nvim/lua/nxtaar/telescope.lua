local telescope = require('telescope.builtin')
local register_action = require('nxtaar.actions').register_action

register_action('telescope.show-references', function()
    telescope.lsp_references()
end)
