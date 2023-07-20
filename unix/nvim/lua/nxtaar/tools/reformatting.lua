local tsj = require('treesj')
local register_keymap_action = require('nxtaar.core.keymapper').register_keymap_action

tsj.setup({ use_default_keymaps = false })

register_keymap_action('reformat.toggle', tsj.toggle)
register_keymap_action('reformat.split', tsj.split)
register_keymap_action('reformat.join', tsj.join)
