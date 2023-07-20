local harpoon_ui = require('harpoon.ui')
local harpoon_mark = require('harpoon.mark')
local hop = require('hop')
local directions = require('hop.hint').HintDirection

local register_keymap_action = require('nxtaar.core.keymapper').register_keymap_action

register_keymap_action('navigation.go-to-previous', harpoon_ui.nav_prev)
register_keymap_action('navigation.go-to-next', harpoon_ui.nav_next)
register_keymap_action('navigation.mark-file', harpoon_mark.add_file)
register_keymap_action('navigation.toggle-menu', harpoon_ui.toggle_quick_menu)

register_keymap_action('navigation.line.next-symbol', function()
    hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true })
end)
register_keymap_action('navigation.line.previous-symbol', function()
    hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true })
end)

register_keymap_action('navigation.line.next-symbol-before-cursor', function()
    hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })
end)
register_keymap_action('navigation.line.previous-symbol-before-curson', function()
    hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })
end)

register_keymap_action('navigation.hop-2chars', 'HopChar2', 'cmd')
register_keymap_action('navigation.hop-line', 'HopLine', 'cmd')
register_keymap_action('navigation.hop-vertical', 'HopVertical', 'cmd')
register_keymap_action('navigation.hop-word', 'HopWord', 'cmd')
register_keymap_action('navigation.hop-pattern', 'HopPattern', 'cmd')
