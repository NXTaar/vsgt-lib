local utils = require('nxtaar.tools.buffers.utils')

local function calculate_unsaved_meta(buffers)
    local has_unsaved_buffers = false
    local registry = {}

    for _, bufnr in ipairs(buffers) do
        local changed = vim.api.nvim_buf_get_option(bufnr, 'modified')
        registry[bufnr] = changed

        if not has_unsaved_buffers then
            has_unsaved_buffers = changed
        end
    end

    return {
        registry,
        has_unsaved_buffers,
    }
end

return function(bufnrs)
    local changes_registry, has_unsaved_buffers = unpack(calculate_unsaved_meta(bufnrs))
    local longest_buffer_filename_length = utils.get_longest_buffer_filename_length(bufnrs)
    local biggest_buffer_digit = math.max(unpack(bufnrs))
    local longest_repo_name_length = utils.get_longest_buffer_reponame_length(bufnrs)
    local without_repos = longest_repo_name_length == 0
    return {
        longest_repo_name_length = longest_repo_name_length,
        without_repos = without_repos,
        biggest_buffer_digit = biggest_buffer_digit,
        longest_buffer_filename_length = longest_buffer_filename_length,
        changes_registry = changes_registry,
        has_unsaved_buffers = has_unsaved_buffers,
    }
end
