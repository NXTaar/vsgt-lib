local trouble = require('trouble')
local register_keymap_action = require('nxtaar.core.keymapper').register_keymap_action
local register_action = require('nxtaar.utils.actions').register_action

trouble.setup()

register_keymap_action('problems.show-in-file', 'TroubleToggle document_diagnostics', 'cmd')
register_keymap_action('problems.show-in-workspace', 'TroubleToggle workspace_diagnostics', 'cmd')
register_keymap_action('problems.toggle', 'TroubleToggle', 'cmd')

register_action('trouble.show-references', function()
    vim.cmd('TroubleToggle lsp_references')
end)
