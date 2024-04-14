local telescope = require('telescope.builtin')
local themes = require('telescope.themes')
local telescope_actions = require('telescope.actions')
local display_buffers = require('nxtaar.tools.buffers').display_buffers_telescope
local action_state = require('telescope.actions.state')
local action_utils = require('telescope.actions.utils')
local ask_to_confirm = require('nxtaar.tools.telescope_pretty_buffers.utils').ask_to_confirm

return function()
    local bufs_raw = vim.api.nvim_list_bufs()

    if #bufs_raw == 1 then
        print('Only one buffer')
        return
    end

    telescope.buffers(themes.get_dropdown({
        entry_maker = display_buffers(),
        previewer = false,
        multi_icon = '',
        attach_mappings = function(_, map)
            map({ 'i', 'n' }, '<Tab>', function(prompt_bufnr)
                telescope_actions.toggle_selection(prompt_bufnr)
                local picker = action_state.get_current_picker(prompt_bufnr)

                local selected_registry = {}

                action_utils.map_selections(prompt_bufnr, function(entry)
                    selected_registry[entry.bufnr] = true
                end)

                action_utils.map_entries(prompt_bufnr, function(entry)
                    entry.selected = selected_registry[entry.bufnr] or false
                end)
                picker:move_selection(0)
            end)
            map({ 'i', 'n' }, '<S-Tab>', telescope_actions.toggle_selection)

            map('n', 'dd', function(prompt_bufnr)
                local picker = action_state.get_current_picker(prompt_bufnr)
                local selection = picker:get_multi_selection()
                local num_selections = #selection

                if num_selections == 0 then
                    return
                end

                if num_selections == 1 then
                    return telescope_actions.delete_buffer(prompt_bufnr)
                end

                local confirmation = ask_to_confirm(string.format("Delete '%s' buffers? [y/n]: ", num_selections))

                if confirmation then
                    telescope_actions.delete_buffer(prompt_bufnr)
                end
            end)
            -- map({ 'i', 'n' }, '<C-r>', function(_prompt_bufnr)
            --     print 'You typed <C-r>'
            -- end, { desc = 'desc for which key' })

            -- needs to return true if you want to map default_mappings and
            -- false if not
            return true
        end,
    }))
end
